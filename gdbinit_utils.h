#import "stdio.h"
#import <objc/objc.h>

/**
 * Given a type encoding string (see Type Encodings in the Objective-C Runtime Programming guide),
 * return the corresponding sizeof (correct with respect to architecture and alignment issues)
 */
size_t gdbinit_utils_sizeof(char *type);

/**
 * Given an address on the stack, print a complete description if it corresponds to a method call.
 * Return YES on SUCCESS, NO on failure
 */
BOOL gdbinit_utils_print_method(void *stack_address);
