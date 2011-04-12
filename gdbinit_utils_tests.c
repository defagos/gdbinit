#import "assert.h"
#import "gdbinit_utils.h"

int main(int argc, char *argv[])
{
#if defined(__i386__)
    // Valid type strings
    assert(gdbinit_utils_sizeof("c") == 4);
    assert(gdbinit_utils_sizeof("i") == 4);
    assert(gdbinit_utils_sizeof("s") == 4);
    assert(gdbinit_utils_sizeof("l") == 4);
    assert(gdbinit_utils_sizeof("q") == 8);
    assert(gdbinit_utils_sizeof("f") == 4);
    assert(gdbinit_utils_sizeof("d") == 8);
    assert(gdbinit_utils_sizeof("^d") == 4);
    assert(gdbinit_utils_sizeof("^^d") == 4);
    assert(gdbinit_utils_sizeof("*") == 4);
    assert(gdbinit_utils_sizeof("@") == 4);
    assert(gdbinit_utils_sizeof("#") == 4);
    assert(gdbinit_utils_sizeof(":") == 4);
    assert(gdbinit_utils_sizeof("[15l]") == 4);
    assert(gdbinit_utils_sizeof("[15^q]") == 4);
    
    // Invalid type strings
    assert(gdbinit_utils_sizeof("^") == 0);
    assert(gdbinit_utils_sizeof("[") == 0);
    assert(gdbinit_utils_sizeof("]") == 0);
    assert(gdbinit_utils_sizeof("[]") == 0);
    assert(gdbinit_utils_sizeof("[15]") == 0);
    assert(gdbinit_utils_sizeof("[i]") == 0);
#elif defined(__x86_64__)
    // Valid type strings
    assert(gdbinit_utils_sizeof("c") == 8);
    assert(gdbinit_utils_sizeof("i") == 8);
    assert(gdbinit_utils_sizeof("s") == 8);
    assert(gdbinit_utils_sizeof("l") == 8);
    assert(gdbinit_utils_sizeof("q") == 8);
    assert(gdbinit_utils_sizeof("f") == 8);
    assert(gdbinit_utils_sizeof("d") == 8);
    assert(gdbinit_utils_sizeof("^d") == 8);
    assert(gdbinit_utils_sizeof("^^d") == 8);
    assert(gdbinit_utils_sizeof("*") == 8);
    assert(gdbinit_utils_sizeof("@") == 8);
    assert(gdbinit_utils_sizeof("#") == 8);
    assert(gdbinit_utils_sizeof(":") == 8);    
    assert(gdbinit_utils_sizeof("[15l]") == 8);
    assert(gdbinit_utils_sizeof("[15^q]") == 8);
    
    // Invalid type strings
    assert(gdbinit_utils_sizeof("^") == 0);
    assert(gdbinit_utils_sizeof("[") == 0);
    assert(gdbinit_utils_sizeof("]") == 0);
    assert(gdbinit_utils_sizeof("[]") == 0);
    assert(gdbinit_utils_sizeof("[15]") == 0);
    assert(gdbinit_utils_sizeof("[i]") == 0);    
#endif
}