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
    assert(gdbinit_utils_sizeof("?") == 4);
    assert(gdbinit_utils_sizeof("[15l]") == 4);
    assert(gdbinit_utils_sizeof("[15^q]") == 4);
    assert(gdbinit_utils_sizeof("[3^q][4^q][5^q]") == 4 + 4 + 4);
    assert(gdbinit_utils_sizeof("{?=icq}") == 4 + 4 + 8);
    assert(gdbinit_utils_sizeof("{?=icq}{?=ls}") == (4 + 4 + 8) + (4 + 4));
    assert(gdbinit_utils_sizeof("^{?=icq}") == 4);
    assert(gdbinit_utils_sizeof("^^{some_name_alone}") == 4);
    assert(gdbinit_utils_sizeof("{some_name=icq{?=l^id}}") == 4 + 4 + 8 + (4 + 4 + 8));
    assert(gdbinit_utils_sizeof("cQf{some_name=L*^i[16i]s{other_name=fd}}c{another_name=icq}") 
           == 4 + 8 + 4 + (4 + 4 + 4 + 4 + 4 + (4 + 8)) + 4 + (4 + 4 + 8));
    
    // Invalid type strings
    assert(gdbinit_utils_sizeof("^") == 0);
    assert(gdbinit_utils_sizeof("[") == 0);
    assert(gdbinit_utils_sizeof("]") == 0);
    assert(gdbinit_utils_sizeof("[]") == 0);
    assert(gdbinit_utils_sizeof("[15]") == 0);
    assert(gdbinit_utils_sizeof("[i]") == 0);
    assert(gdbinit_utils_sizeof("{") == 0);
    assert(gdbinit_utils_sizeof("}") == 0);
    assert(gdbinit_utils_sizeof("{}") == 0);
    assert(gdbinit_utils_sizeof("{i}") == 0);
    // TODO: =<type> in struct not mandatory iff ^^
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
    assert(gdbinit_utils_sizeof("?") == 8);
    assert(gdbinit_utils_sizeof("[15l]") == 8);
    assert(gdbinit_utils_sizeof("[15^q]") == 8);
    assert(gdbinit_utils_sizeof("[3^q][4^q][5^q]") == 8 + 8 + 8);
    assert(gdbinit_utils_sizeof("{?=icq}") == 8 + 8 + 8);
    assert(gdbinit_utils_sizeof("{?=icq}{?=ls}") == (8 + 8 + 8) + (8 + 8));
    assert(gdbinit_utils_sizeof("^{?=icq}") == 8);
    assert(gdbinit_utils_sizeof("^^{some_name_alone}") == 8);
    assert(gdbinit_utils_sizeof("{some_name=icq{?=l^id}}") == 8 + 8 + 8 + (8 + 8 + 8));
    assert(gdbinit_utils_sizeof("cQf{some_name=L*^i[16i]s{other_name=fd}}c{another_name=icq}") 
           == 8 + 8 + 8 + (8 + 8 + 8 + 8 + 8 + (8 + 8)) + 8 + (8 + 8 + 8));
    
    // Invalid type strings
    assert(gdbinit_utils_sizeof("^") == 0);
    assert(gdbinit_utils_sizeof("[") == 0);
    assert(gdbinit_utils_sizeof("]") == 0);
    assert(gdbinit_utils_sizeof("[]") == 0);
    assert(gdbinit_utils_sizeof("[15]") == 0);
    assert(gdbinit_utils_sizeof("[i]") == 0);
    assert(gdbinit_utils_sizeof("{") == 0);
    assert(gdbinit_utils_sizeof("}") == 0);
    assert(gdbinit_utils_sizeof("{}") == 0);  
    assert(gdbinit_utils_sizeof("{i}") == 0);
    // TODO: =<type> in struct not mandatory iff ^^
#endif
}