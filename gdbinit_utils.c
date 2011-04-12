#include "ctype.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

// TODO: Is it possible to write a function which can return if we are running into
//       the simulator or the device?
//   -> Yep! This is at least possible using internal variables and the preproc
//      ifdef, passing some preproc macro when building for the device

#define ALIGNED_SIZEOF(type)                aligned_sizeof(sizeof(type))

static size_t aligned_sizeof(size_t size)
{
    size_t aligned_size = (size / sizeof(void *)) * sizeof(void *);
    if (size % sizeof(void *) != 0) {
        aligned_size += sizeof(void *);
    }
    return aligned_size;
}

/**
 * Find the next sub-type at the beginning of the str string, and return
 * its length (or 0 if none was found) 
 */
static size_t gdbinit_utils_next_subtype_length(char *str)
{   
    // C-array
    if (*str == '[') {
        char *end_pos = strrchr(str + 1, ']');
        if (end_pos) {
            return end_pos - str + 1;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing ']'\n");
            return 0;
        }
    }
    // C-struct
    else if (*str == '{') {
        char *end_pos = strrchr(str + 1, '}');
        if (end_pos) {
            return end_pos - str + 1;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing '}'\n");
            return 0;
        }
    }
    // Union
    else if (*str == '(') {
        char *end_pos = strrchr(str + 1, ')');
        if (end_pos) {
            return end_pos - str + 1;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing ')'\n");
            return 0;
        }
        return end_pos ? end_pos - str + 1 : 0;
    }
    // Bit field
    else if (*str == 'b') {
        char *end_pos = str + 1;
        while (isdigit(*end_pos)) {
            ++end_pos;
        }
        if (end_pos != str + 1) {
            return end_pos - str;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing bitfield length\n");
            return 0;
        }
    }
    // All other cases: Single character
    else {
        return *str != '\0' ? 1 : 0;
    }
}

/**
 * Take a string encoding as input (e.g. lq{?=icq{?=cid}^i}c) and returns the total
 * corresponding size
 */
size_t gdbinit_utils_sizeof(char *type)
{
    size_t size = 0;
    char *pos = type;
    size_t index = pos - type;
    
    // Stops when all output has been prcessed or if an error is encountered
    size_t next_subtype_length = gdbinit_utils_next_subtype_length(pos);
    while (next_subtype_length != 0) {
        // Extract the next subtype string
        char *subtype = calloc(next_subtype_length + 1, sizeof(char));
        strncpy(subtype, pos, next_subtype_length);
        
        // Pointer
        if (*subtype == '^') {
            // Discard the pointee type information; not interesting
            pos += next_subtype_length;
            next_subtype_length = gdbinit_utils_next_subtype_length(pos);
            if (next_subtype_length != 0) {
                size += ALIGNED_SIZEOF(void *);
            }
            else {
                printf("[ERROR] Missing pointer type at index %ld\n", index);
                free(subtype);
                return 0;
            }
        }
        // C-array
        else if (*subtype == '[') {
            size += ALIGNED_SIZEOF(void *);
            // Check that length information is available
            char *array_subtype_pos = subtype + 1;
            while (isdigit(*array_subtype_pos)) {
                ++array_subtype_pos;
            }
            if (array_subtype_pos != subtype + 1) {
                // Check the type string format (do not use it, though; not needed!)
                size_t array_type_length = (char *)(subtype + next_subtype_length - 1) - array_subtype_pos;
                char *array_type = calloc(array_type_length + 1, sizeof(char));
                strncpy(array_type, array_subtype_pos, array_type_length);
                if (gdbinit_utils_sizeof(array_type) == 0) {
                    printf("[ERROR] Incorrect object size in array at index %ld\n", index);
                    free(array_type);
                    free(subtype);
                    return 0;
                }
                free(array_type);
            }
            else {
                printf("[ERROR] Missing array length information at index %ld\n", index);
                free(subtype);
                return 0;
            }
        }
        // C-struct
        else if (*subtype == '{') {
            // Find the C-struct type string; not always specified if pointer to
            // pointer to struct (see Type Encodings in the Objective-C Runtime 
            // Programming guide)
            char *equal_pos = strchr(subtype, '=');
            if (equal_pos) {
                size_t struct_type_length = next_subtype_length - (equal_pos - subtype) - 2;
                char *struct_type = calloc(struct_type_length + 1, sizeof(char));
                strncpy(struct_type, equal_pos + 1, struct_type_length);
                size += gdbinit_utils_sizeof(struct_type);
                free(struct_type);
                if (size == 0) {
                    printf("[ERROR] Invalid size of zero for struct defined at index %ld\n", index);
                    free(subtype);
                    return 0;
                }
            }
        }
        // Union
        else if (*subtype == '(') {
            // TODO: Probably find max of sizeofs
        }
        // Bit field
        else if (*subtype == 'b') {
            // TODO: Probably number of bits, aligned
        }
        // Other pointer types
        else if (strchr("@*#:", *subtype)) {
            size += ALIGNED_SIZEOF(void *);
        }
        // Int
        else if (strchr("iI", *subtype)) {
            size += ALIGNED_SIZEOF(int);
        }
        // Short
        else if (strchr("sS", *subtype)) {
            size += ALIGNED_SIZEOF(short);
        }
        // Long
        else if (strchr("lL", *subtype)) {
            size += ALIGNED_SIZEOF(long);
        }
        // Long long
        else if (strchr("qQ", *subtype)) {
            size += ALIGNED_SIZEOF(long long);
        }
        // Character
        else if (strchr("cC", *subtype)) {
            size += ALIGNED_SIZEOF(char);
        }
        // Float
        else if (*subtype == 'f') {
            size += ALIGNED_SIZEOF(float);
        }
        // Double
        else if (*subtype == 'd') {
            size += ALIGNED_SIZEOF(double);
        }
        // Boolean: Only for C99 or C++ (see Type Encodings in the Objective-C Runtime 
        // Programming guide)
#if __STDC_VERSION__ >= 199901L
        else if (*subtype == 'B') {
            size += ALIGNED_SIZEOF(_Bool);
        }
#elif defined(__cplusplus)
        else if (*subtype == 'B') {
            size += ALIGNED_SIZEOF(bool);
        }
#endif
        // Void or unknown: Use "natural" size
        else if (strchr("v?", *subtype)){
            size += ALIGNED_SIZEOF(void *);
        }
        // Unsupported type; should never happen
        else {
            printf("[ERROR] Unsupported type %c found at index %ld\n", *subtype, index);
            free(subtype);
            return 0;
        }
        
        free(subtype);
        
        // Ready for reading next subtype
        pos += next_subtype_length;
        index = pos - type;
        next_subtype_length = gdbinit_utils_next_subtype_length(pos);
    }
    
    if (*pos != '\0') {
        printf("[ERROR] The type at index %ld (first character: %c) could not be fully parsed\n", index, *pos);
        return 0;
    }
    
    return size;
}

int main(int argc, char *argv[])
{
    size_t s = gdbinit_utils_sizeof(argv[1]);
    printf("%ld\n", s);
}