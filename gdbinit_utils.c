#include "stdio.h"
#include "stdlib.h"
#include "string.h"

// TODO: Is it possible to write a function which can return if we are running into
//       the simulator or the device?

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
 * Take a string encoding as input (e.g. lq{?=icq{?=cid}^i}c) and returns the total
 * corresponding size
 */
size_t gdbinit_utils_sizeof(char *type)
{
    // TODO: See Runtime programming guide:
    //  "However, another level of indirection removes the internal type specification:
    //  ^^{example}"
    
    size_t size = 0;
    char *pos = type;
    while (*pos != '\0') {
        // Types derived from pointer with no additional type information
        if (strchr("@^*#:", pos[0])) {
            size += ALIGNED_SIZEOF(void *);
            ++pos;
        }
        // Int
        else if (strchr("iI", pos[0])) {
            size += ALIGNED_SIZEOF(int);
            ++pos;
        }
        // Short
        else if (strchr("sS", pos[0])) {
            size += ALIGNED_SIZEOF(short);
            ++pos;
        }
        // Long
        else if (strchr("lL", pos[0])) {
            size += ALIGNED_SIZEOF(long);
            ++pos;
        }
        // Long long
        else if (strchr("qQ", pos[0])) {
            size += ALIGNED_SIZEOF(long long);
            ++pos;
        }
        // Character
        else if (strchr("cC", pos[0])) {
            size += ALIGNED_SIZEOF(char);
            ++pos;
        }
        // Float
        else if (pos[0] == 'f') {
            size += ALIGNED_SIZEOF(float);
            ++pos;
        }
        // Double
        else if (pos[0] == 'd') {
            size += ALIGNED_SIZEOF(double);
            ++pos;
        }
        else if (pos[0] == '^') {
            size += ALIGNED_SIZEOF(void *);
            
            // TODO: Move cursor after type information (warning: the case "pointer 
            //       to struct" has to be taken into account, i.e. type information
            //       is not always a single character!)
        }
        // C-array
        else if (pos[0] == '[') {
            size += ALIGNED_SIZEOF(void *);
            
            // TODO: Move cursor after ]
        }
        // C-struct
        else if (pos[0] == '{') {
            // Extract the internal struct layout information and
            // calculate its size
            char *begin_pos = strchr(pos, '=') + 1;
            char *end_pos = strrchr(pos, '}');
            size_t length = end_pos - begin_pos;
            char *layout_cstr = calloc(length + 1, sizeof(char));
            strncpy(layout_cstr, begin_pos, length);
            size += gdbinit_utils_sizeof(layout_cstr);
            free(layout_cstr);
            
            // Move the cursor after the struct information block
            pos = end_pos + 1;
        }
        // Union
        else if (pos[0] == '(') {
            // TODO
            size += 17;        
        }
        // Bit field
        else if (pos[0] == 'b') {
            // TODO
            size += 17;        
        }
        // Unknown, boolean or void: Use "natural" size
        else {
            size += ALIGNED_SIZEOF(int);
        }
    }
    return size;
}
