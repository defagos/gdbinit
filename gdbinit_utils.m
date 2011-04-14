#import "gdbinit_utils.h"

#import "ctype.h"
#import "stdlib.h"
#import "string.h"

#import <objc/runtime.h>

// TODO: Is it possible to write a function which can return if we are running into
//       the simulator or the device?
//   -> Yep! This is at least possible using internal variables and the preproc
//      ifdef, passing some preproc macro when building for the device

// TODO: Ok, I should really have used a parser and a grammar here. Maybe later

// TODO: - Use NSGetSizeAndAlignment instead
#define ALIGNED_SIZEOF(type)                aligned_sizeof(sizeof(type))

#define FALSE                               0
#define TRUE                                1

// Function declarations
static char *gdbinit_utils_find_closing_bracket(char *str, char bracket);
static size_t aligned_sizeof(size_t size);
static size_t gdbinit_utils_next_subtype_length(char *str);
static size_t gdbinit_utils_sizeof_composite(char *type, int composite);

size_t gdbinit_utils_sizeof(char *type)
{
    return gdbinit_utils_sizeof_composite(type, TRUE);
}

BOOL gdbinit_utils_print_method(void *stack_address)
{
    // TODO: Implementation
    return YES;
}

/**
 * Starting from str, find the next closing bracket for the one given as parameter. Return
 * NULL if not found
 */
static char *gdbinit_utils_find_closing_bracket(char *str, char opening_bracket)
{
    char closing_bracket;
    switch (opening_bracket) {
        case _C_UNION_B:
            closing_bracket = _C_UNION_E;
            break;
            
        case _C_ARY_B:
            closing_bracket = _C_ARY_E;
            break;
        
        case _C_STRUCT_B:
            closing_bracket = _C_STRUCT_E;
            break;
            
        default:
            printf("[ERROR] Unsupported bracket");
            return NULL;
            break;
    }
    
    int bracket_pairs = 1;
    char *pos = str;
    while (*pos != '\0') {
        if (*pos == opening_bracket) {
            ++bracket_pairs;
        }
        else if (*pos == closing_bracket) {
            --bracket_pairs;
            if (bracket_pairs == 0) {
                return pos;
            }
        }
        ++pos;
    }
    return NULL;
}

/**
 * Return a size correct with respect to alignment and architecture
 */
static size_t aligned_sizeof(size_t size)
{
    size_t aligned_size = (size / sizeof(void *)) * sizeof(void *);
    if (size % sizeof(void *) != 0) {
        aligned_size += sizeof(void *);
    }
    return aligned_size;
}

/**
 * Find the next well-formed sub-type at the beginning of the str string, and return
 * its length (or 0 if none was found) 
 */
static size_t gdbinit_utils_next_subtype_length(char *str)
{   
    // Pointer
    if (*str == _C_PTR) {
        size_t pointer_type_length = gdbinit_utils_next_subtype_length(str + 1);
        if (pointer_type_length == 0) {
            printf("[ERROR] Missing pointee type\n");
            return 0;
        }
        return 1 + pointer_type_length;
    }
    // C-array
    else if (*str == _C_ARY_B) {
        char *end_pos = gdbinit_utils_find_closing_bracket(str + 1, _C_ARY_B);
        if (end_pos) {
            // Check that length information is available
            char *array_subtype_pos = str + 1;
            while (isdigit(*array_subtype_pos)) {
                ++array_subtype_pos;
            }
            if (array_subtype_pos != str + 1) {
                // Check the type string format (do not use it, though; not needed!)
                size_t array_type_length = end_pos - array_subtype_pos;
                char *array_type = calloc(array_type_length + 1, sizeof(char));
                strncpy(array_type, array_subtype_pos, array_type_length);
                if (gdbinit_utils_sizeof_composite(array_type, FALSE) == 0) {
                    printf("[ERROR] Incorrect object size in array\n");
                    free(array_type);
                    return 0;
                }
                free(array_type);
            }
            else {
                printf("[ERROR] Missing array length information at index\n");
                return 0;
            }
            
            return end_pos - str + 1;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing '%c'\n", _C_ARY_E);
            return 0;
        }
    }
    // C-struct
    else if (*str == _C_STRUCT_B) {
        char *end_pos = gdbinit_utils_find_closing_bracket(str + 1, _C_STRUCT_B);
        if (end_pos) {
            return end_pos - str + 1;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing '%c'\n", _C_STRUCT_E);
            return 0;
        }
    }
    // Union
    else if (*str == _C_UNION_B) {
        char *end_pos = gdbinit_utils_find_closing_bracket(str + 1, _C_UNION_B);
        if (end_pos) {
            return end_pos - str + 1;
        }
        else {
            printf("[ERROR] Incorrect type syntax: Missing '%c'\n", _C_UNION_E);
            return 0;
        }
        return end_pos ? end_pos - str + 1 : 0;
    }
    // Bit field
    else if (*str == _C_BFLD) {
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
 * If composite is set to TRUE, then the type we calculate the sizeof can be a composite
 * of several subtypes (e.g. iQ, cdl), otherwise only a single subtype must be found
 * (e.g. i, ^i, [15l])
 */
static size_t gdbinit_utils_sizeof_composite(char *type, int composite)
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
        if (*subtype == _C_PTR) {
            size += ALIGNED_SIZEOF(void *);
        }
        // C-array
        else if (*subtype == _C_ARY_B) {
            size += ALIGNED_SIZEOF(void *);
        }
        // C-struct
        else if (*subtype == _C_STRUCT_B) {
            // Find the C-struct type string; not always specified if pointer to
            // pointer to struct (see Type Encodings in the Objective-C Runtime 
            // Programming guide)
            char *equal_pos = strchr(subtype, '=');
            if (equal_pos) {
                size_t struct_type_length = next_subtype_length - (equal_pos - subtype) - 2;
                char *struct_type = calloc(struct_type_length + 1, sizeof(char));
                strncpy(struct_type, equal_pos + 1, struct_type_length);
                size += gdbinit_utils_sizeof_composite(struct_type, TRUE);
                free(struct_type);
                if (size == 0) {
                    printf("[ERROR] Invalid size of zero for struct defined at index %ld\n", index);
                    free(subtype);
                    return 0;
                }
            }
        }
        // Union
        else if (*subtype == _C_UNION_B) {
            // TODO: Probably find max of sizeofs
        }
        // Bit field
        else if (*subtype == _C_BFLD) {
            // TODO: Probably number of bits, aligned
        }
        // Other pointer types
        else if (*subtype == _C_ID
                 || *subtype == _C_CHARPTR
                 || *subtype == _C_CLASS
                 || *subtype == _C_SEL) {
            size += ALIGNED_SIZEOF(void *);
        }
        // Int
        else if (*subtype == _C_INT
                 || *subtype == _C_UINT) {
            size += ALIGNED_SIZEOF(int);
        }
        // Short
        else if (*subtype == _C_SHT
                 || *subtype == _C_USHT) {
            size += ALIGNED_SIZEOF(short);
        }
        // Long
        else if (*subtype == _C_LNG
                 || *subtype == _C_ULNG) {
            size += ALIGNED_SIZEOF(long);
        }
        // Long long
        else if (*subtype == _C_LNG_LNG
                 || *subtype == _C_ULNG_LNG) {
            size += ALIGNED_SIZEOF(long long);
        }
        // Character
        else if (*subtype == _C_CHR
                 || *subtype == _C_UCHR) {
            size += ALIGNED_SIZEOF(char);
        }
        // Float
        else if (*subtype == _C_FLT) {
            size += ALIGNED_SIZEOF(float);
        }
        // Double
        else if (*subtype == _C_DBL) {
            size += ALIGNED_SIZEOF(double);
        }
        // Boolean: Only for C99 or C++ (see Type Encodings in the Objective-C Runtime 
        // Programming guide)
#if __STDC_VERSION__ >= 199901L
        else if (*subtype == _C_BOOL) {
            size += ALIGNED_SIZEOF(_Bool);
        }
#elif defined(__cplusplus)
        else if (*subtype == _C_BOOL) {
            size += ALIGNED_SIZEOF(bool);
        }
#endif
        // Void or unknown: Use "natural" size
        else if (*subtype == _C_VOID
                 || *subtype == _C_UNDEF) {
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
        next_subtype_length = gdbinit_utils_next_subtype_length(pos);
        if (! composite && next_subtype_length != 0) {
            printf("[ERROR] The type at index %ld cannot be a composite\n", index);
            return 0;
        }
        index = pos - type;
    }
    
    if (*pos != '\0') {
        printf("[ERROR] The type at index %ld (first character: %c) could not be fully parsed\n", index, *pos);
        return 0;
    }
    
    return size;
}
