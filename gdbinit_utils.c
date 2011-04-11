#include "stdio.h"
#include "string.h"

#define ALIGNED_SIZEOF(type)                aligned_sizeof(sizeof(type))

static size_t aligned_sizeof(size_t size)
{
    size_t aligned_size = (size / sizeof(void *)) * sizeof(void *);
    if (size % sizeof(void *) != 0) {
        aligned_size += sizeof(void *);
    }
    return aligned_size;
}

size_t gdbinit_utils_sizeof(char *type)
{
    // Types derived from pointer
    if (strchr("@^*#:[", type[0])) {
        return ALIGNED_SIZEOF(void *);
    }
    // Int
    else if (strchr("iI", type[0])) {
        return ALIGNED_SIZEOF(int);
    }
    // Short
    else if (strchr("sS", type[0])) {
        return ALIGNED_SIZEOF(short);
    }
    // Long
    else if (strchr("lL", type[0])) {
        return ALIGNED_SIZEOF(long);
    }
    // Long long
    else if (strchr("qQ", type[0])) {
        return ALIGNED_SIZEOF(long long);
    }
    // Character
    else if (strchr("cC", type[0])) {
        return ALIGNED_SIZEOF(char);
    }
    // Float
    else if (type[0] == 'f') {
        return ALIGNED_SIZEOF(float);
    }
    // Double
    else if (type[0] == 'd') {
        return ALIGNED_SIZEOF(double);
    }
    // C-struct
    else if (type[0] == '{') {
        // TODO
        return 17;
    }
    // Union
    else if (type[0] == '(') {
        // TODO
        return 17;        
    }
    // Bit field
    else if (type[0] == 'b') {
        // TODO
        return 17;        
    }
    // Unknown, boolean or void: Use "natural" size
    else {
        return ALIGNED_SIZEOF(int);
    }
}
