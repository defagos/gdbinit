# **********************************************************************************************
# Breakpoint management 
# **********************************************************************************************

# ----------------------------------------------------------------------------------------------
# Breakpoint list
# ----------------------------------------------------------------------------------------------

define bpl
    if $argc == 0
        info breakpoints
    else
        help bpl
    end
end

document bpl
List all currently defined breakpoints.
end

# ----------------------------------------------------------------------------------------------
# Standard breakpoints
# ----------------------------------------------------------------------------------------------

define bp
    if $argc == 0
        break
    else 
    if $argc == 1
        break $arg0
    else
        help bp
    end
    end
end

document bp
Set a breakpoint at some location.
Usage: bp [LOCATION]
LOCATION may be a line number, a function or method name, or "*" followed by an address.
Method names must be specified between single quotes, and should be decorated with leading + 
or -.

If a function or method name is prefixed with a "*", the breakpoint will be put before
the function or method prologue, otherwise it will be put after it.

With no arg, the current execution address of the selected stack frame is used.

Examples:
    bp CFStringCreateWithFormat              Break on C function (after prologue)
    bp *CFStringCreateWithFormat             Break on C function (before prologue)
    bp '+[NSString stringWithFormat:]'       Break on Objective-C method (after prologue)
    bp *'+[NSString stringWithFormat:]'      Break on Objective-C method (before prologue)
    bp *0x1325dd0s                           Break on memory instruction at 0x1325dd0s
    bp 17                                    Break on line 17 in current source file

Do "help break" for more information.
end

# ----------------------------------------------------------------------------------------------
# Temporary breakpoints
# ----------------------------------------------------------------------------------------------

define bpt
    if $argc == 0
        tbreak
    else 
    if $argc == 1
        tbreak $arg0
    else
        help bpt
    end
    end
end

document bpt
Set a temporary breakpoint at some location.
Usage: bpt [LOCATION]
LOCATION may be a line number, a function or method name, or "*" followed by an address.
Method names must be specified between single quotes, and should be decorated with leading + 
or -.

If a function or method name is prefixed with a "*", the breakpoint will be put before
the function or method prologue, otherwise it will be put after it.

With no arg, the current execution address of the selected stack frame is used.

Examples:
    bpt CFStringCreateWithFormat             Break on C function (after prologue)
    bpt *CFStringCreateWithFormat            Break on C function (before prologue)
    bpt '+[NSString stringWithFormat:]'      Break on Objective-C method (after prologue)
    bpt *'+[NSString stringWithFormat:]'     Break on Objective-C method (before prologue)
    bpt *0x1325dd0s                          Break on memory instruction at 0x1325dd0s
    bpt 17                                   Break on line 17 in current source file

Do "help tbreak" for more information.
end

# ----------------------------------------------------------------------------------------------
# Memory breakpoints
# ----------------------------------------------------------------------------------------------
define bpm
    if $argc == 1
        awatch $arg0
    else 
        help bpm
    end
end

document bpm
Set a memory breakpoint (watchpoint) on some expression.
Usage: bpm EXPRESSION
A memory breakpoint stops the execution of the program whenever the value of EXPRESSION is 
either read or written.

With no arg, the current execution address of the selected stack frame is used.

Examples:
    bpm *0x1325dd0s                          Watchpoint on memory instruction at 0x1325dd0s
    bpm 17                                   Watchpoint on line 17 in current source file

Do "help awatch" for more information.
end

# ----------------------------------------------------------------------------------------------
# Hardware assisted breakpoints
# ----------------------------------------------------------------------------------------------
define bph
    if $argc == 0
        hb
    else 
    if $argc == 1
        hb $arg0
    else
        help bph
    end
    end
end

document bph
Set a hardware assisted breakpoint at some location.
Usage: bph [LOCATION]
LOCATION may be a line number, a function or method name, or "*" followed by an address.
Method names must be specified between single quotes, and should be decorated with leading + 
or -.

If a function or method name is prefixed with a "*", the breakpoint will be put before
the function or method prologue, otherwise it will be put after it.

With no arg, the current execution address of the selected stack frame is used.

Examples:
    bph CFStringCreateWithFormat             Break on C function (after prologue)
    bph *CFStringCreateWithFormat            Break on C function (before prologue)
    bph '+[NSString stringWithFormat:]'      Break on Objective-C method (after prologue)
    bph *'+[NSString stringWithFormat:]'     Break on Objective-C method (before prologue)
    bph *0x1325dd0s                          Break on memory instruction at 0x1325dd0s
    bph 17                                   Break on line 17 in current source file

Do "help hb" for more information.
end

# ----------------------------------------------------------------------------------------------
# Clearing breakpoints
# ----------------------------------------------------------------------------------------------

define bpc
    if $argc == 0
        clear
    else 
    if $argc == 1
        clear $arg0
    else
        help bpc
    end
    end
end

document bpc
Clear all breakpoints at some location.
Usage: bpc [LOCATION]
LOCATION may be a line number, a function or method name, or "*" followed by an address.
Method names must be specified between single quotes, and should be decorated with leading + 
or -.

If a function or method name is prefixed with a "*", the breakpoint will be put before
the function or method prologue, otherwise it will be put after it.

With no arg, the current execution address of the selected stack frame is used.

Examples:
    bpc CFStringCreateWithFormat             for C function breakpoints (after prologue)
    bpc *CFStringCreateWithFormat            for C function breakpoints (before prologue)
    bpc '+[NSString stringWithFormat:]'      for Objective-C method breakpoints (after prologue)
    bpc *'+[NSString stringWithFormat:]'     for Objective-C method breakpoints (before prologue)
    bpc *0x1325dd0s                          for breakpoints located on instruction at 0x1325dd0s
    bpc 17                                   for breakpoints on line 17 in current source file

Do "help clear" for more information.
end

# ----------------------------------------------------------------------------------------------
# Enabling breakpoints
# ----------------------------------------------------------------------------------------------

define bpe
    if $argc == 0
        enable
    else 
    if $argc == 1
        enable $arg0
    else 
    if $argc == 2
        enable $arg0 $arg1
    else 
    if $argc == 3
        enable $arg0 $arg1 $arg2
    else 
    if $argc == 4
        enable $arg0 $arg1 $arg2 $arg3
    else 
    if $argc == 5
        enable $arg0 $arg1 $arg2 $arg3 $arg4
    else 
    if $argc == 6
        enable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5
    else
    if $argc == 7
        enable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6
    else 
    if $argc == 8
        enable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7
    else 
    if $argc == 9
        enable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8
    else 
    if $ argc == 10
        enable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9
    else
        help bpe
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
end

document bpe
Enable breakpoints (all if none specified)
Usage: bpe [NUM1] [NUM2] ... [NUM10]

Do "help enable" for more information.
end

# ----------------------------------------------------------------------------------------------
# Disabling breakpoints
# ----------------------------------------------------------------------------------------------

define bpd
    if $argc == 0
        disable
    else 
    if $argc == 1
        disable $arg0
    else 
    if $argc == 2
        disable $arg0 $arg1
    else 
    if $argc == 3
        disable $arg0 $arg1 $arg2
    else
    if $argc == 4
        disable $arg0 $arg1 $arg2 $arg3
    else 
    if $argc == 5
        disable $arg0 $arg1 $arg2 $arg3 $arg4
    else 
    if $argc == 6
        disable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5
    else 
    if $argc == 7
        disable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6
    else 
    if $argc == 8
        disable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7
    else 
    if $argc == 9
        disable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8
    else 
    if $ argc == 10
        disable $arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9
    else
        help bpd
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
    end
end

document bpd
Disable breakpoints (all if none specified)
Usage: bpd [NUM1] [NUM2] ... [NUM10]

Do "help disable" for more information.
end


# **********************************************************************************************
# Objective-C
# **********************************************************************************************

# Some useful references:
#     http://www.clarkcox.com/blog/2009/02/04/inspecting-obj-c-parameters-in-gdb/
#     http://developer.apple.com/library/ios/#technotes/tn2239/_index.html

# ----------------------------------------------------------------------------------------------
# Globals
# ----------------------------------------------------------------------------------------------

set unwindonsignal on

# ----------------------------------------------------------------------------------------------
# Getting the (aligned) sizeof for a type given its encoding
# ----------------------------------------------------------------------------------------------

define _aligned_sizeof_for_encoding
    if $argc == 2
        # Types derived from pointer
        if (const char *)strchr("@^*#:", $arg1[0])
            set $$arg0 = sizeof(int *)
        # Int
        else
        if (const char *)strchr("iI", $arg1[0])
            set $$arg0 = sizeof(int)
        # Short
        else
        if (const char *)strchr("sS", $arg1[0])
            # Warning: Min size is always natural type (pointer) size?
            # TODO: Create _minsizeof command
            set $$arg0 = sizeof(int *)
        # Long
        else
        if (const char *)strchr("lL", $arg1[0])
            set $$arg0 = sizeof(long)
        # Long long
        else
        if (const char *)strchr("qQ", $arg1[0])
            set $$arg0 = sizeof(long long)
        # Character
        else
        if (const char *)strchr("cC", $arg1[0])
            # Warning: Min size is always natural type (pointer) size?
            # TODO: Create _minsizeof command
            set $$arg0 = sizeof(int *)
        # Float
        else
        if $arg1[0] == 'f'
            set $$arg0 = sizeof(float)
        # Double
        else
        if $arg1[0] == 'd'
            set $$arg0 = sizeof(double)
        # C-array
        else
        if $arg1[0] == '['
            # TODO: Must read from the type string!
            set $$arg0 = 17
        # C-struct
        else
        if $arg1[0] == '{'
            # TODO: Must read from the type string! (need to factor out this "switch" first!). Loop and add
            set $$arg0 = 17
        # Union
        else
        if $arg1[0] == '('
            # TODO: Must read from the type string! (need to factor out this "switch" first!). Loop and find max
            set $$arg0 = 17
        # Bit field
        else
        if $arg1[0] == 'b'
            # TODO: Must read from the type string! (need to factor out this "switch" first!). Probably
            #       some padding is made to align data
            set $$arg0 = 17
        # Unknown, boolean (?), void (?)
        # TODO: Check those types with a ?
        else
            # Use "natural" size
            set $$arg0 = sizeof(int)
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
    else
        help _aligned_sizeof_for_encoding
    end
end

document _aligned_sizeof_for_encoding
(For internal use) Return the sizeof of a type given its encoding, taking into account
alignment issues.
Usage: _aligned_sizeof_for_encoding OUTPUT_VAR_NAME ENCODING
Sets the variable $OUTPUT_VAR_NAME to this size. If the type is unknown, the pointer size
is returned
end

# ----------------------------------------------------------------------------------------------
# Retrieving arguments (only meant to be used before a function prologue)
# ----------------------------------------------------------------------------------------------

# TODO: Currently only i386 (& iOS simulator). Must deal with 64 bits & iOS device as well!

define _getfunargadr
    if $argc == 2
        if $arg1 < 0
            printf "Incorrect index (must be >= 0)"
        # id parameter
        else
        if $arg1 == 0
            set $$arg0 = (id *)($esp + sizeof(int *))
        # SEL parameter
        else
        if $arg1 == 1
            set $$arg0 = (SEL *)($esp + sizeof(int *) + sizeof(id))
        # Other parameters
        else
            # Extract object and selector first
            _getfunargadr _getfunargadr_pSelf 0
            _getfunargadr _getfunargadr_pSelector 1
        
            # Retrieve the class and method information from the Objective-C runtime
            set $_getfunargadr_class = (Class)object_getClass(*$_getfunargadr_pSelf)
        
            # Class or instance method?
            if ((int)class_isMetaClass($_getfunargadr_class))
                set $_getfunargadr_method = (Method)class_getClassMethod($_getfunargadr_class, *$_getfunargadr_pSelector)
            else
                set $_getfunargadr_method = (Method)class_getInstanceMethod($_getfunargadr_class, *$_getfunargadr_pSelector)
            end
        
            # Sanity check
            set $_getfunargadr_methodNbrArgs = (unsigned int)method_getNumberOfArguments($_getfunargadr_method) 
            if $arg1 >= $_getfunargadr_methodNbrArgs
                printf "Incorrect index (must be < %d)", $_getfunargadr_methodNbrArgs
            else
                # Calculate the address of the requested parameter
                set $_getfunargadr_argAdr = $esp + sizeof(int *) + sizeof(id) + sizeof(SEL)
                set $_getfunargadr_argIndex = 2
                while ($arg1 - $_getfunargadr_argIndex)
                    # Refer to http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
                    # for type encodings
                    set $_getfunargadr_argType = (char *)method_copyArgumentType($_getfunargadr_method, $_getfunargadr_argIndex)
               
                    # Increment the offset according to the argument size
                    printf "Type of arg %d is %s\n", $_getfunargadr_argIndex, $_getfunargadr_argType
                    _aligned_sizeof_for_encoding _getfunargadr_argSize $_getfunargadr_argType
                    set $_getfunargadr_argAdr = $_getfunargadr_argAdr + $_getfunargadr_argSize
                
                    set $_getfunargadr_argIndex = $_getfunargadr_argIndex + 1
                end
            end
        
            printf "Offset: %d\n", $_getfunargadr_argAdr - $esp
        
            # Can now return the calculated parameter address
            set $$arg0 = (int *)$_getfunargadr_argAdr
        end
        end
        end
    else
        help _getfunargadr
    end
end

document _getfunargadr
(For internal use) Fetch function arguments addresses (this command must called before a function 
prologue) of a function having and id and a SEL as first two parameters
Usage: _getfunargadr OUTPUT_VAR_NAME INDEX
Sets the variable $OUTPUT_VAR_NAME to the address of the INDEX-th argument of the function
Uses type TYPE if present, otherwise 'int'
INDEX is 0-based
end

# ----------------------------------------------------------------------------------------------
# Selector call information
# ----------------------------------------------------------------------------------------------

define sci
    if $argc == 0
        # Deal with prototypes having id as first argument and SEL as second one. This is the case
        # for 
        #     objc_msgSend(id self, SEL op, ...)
        # as well as any Objective-C method implementation:
        #     typedef id (*IMP)(id, SEL, ...); 
        # Using the sci command, we can therefore get information about the selector which is called
        # when we stop on on objc_msgSend, but  also when we stop on any Objective-C method call. Nice,
        # isn't it?
        _getfunargadr _sci_pSelf 0
        _getfunargadr _sci_pSelector 1   
    
        # Must be careful enough here NOT to use message sending (would be recursive!)
        printf "Message %s sent to <%s: %p>\n", *$_sci_pSelector, (const char *)object_getClassName(*$_sci_pSelf), *$_sci_pSelf
    else
        help sci
    end
end

document sci
Print information about the message and object passed to objc_msgSend
Usage: sci
This command is meant to be used when breaking on objc_msgSend, a method call or when EXC_BAD_ACCESS
is encountered (usually breaking in objc_msgSend)
end

# ----------------------------------------------------------------------------------------------
# Method information (only meant to be used before a method prologue)
# ----------------------------------------------------------------------------------------------

define mci
    # Whe setting breakpoints on Objective-C methods, we in fact break on the C-function implementing
    # them. Those all have a prototype given by
    #     typedef id (*IMP)(id, SEL, ...)
    _getfunargadr _mci_pSelf 0
    _getfunargadr _mci_pSelector 1
    
    # Retrieve the class and method information from the Objective-C runtime
    set $_mci_class = (Class)object_getClass(*$_mci_pSelf)
    
    # Class or instance method?
    if ((int)class_isMetaClass($_mci_class))
        set $_mci_method = (Method)class_getClassMethod($_mci_class, *$_mci_pSelector)
        printf "Calling method +[%s %s]\n", (const char *)object_getClassName(*$_mci_pSelf), (SEL)method_getName($_mci_method)
    else
        set $_mci_method = (Method)class_getInstanceMethod($_mci_class, *$_mci_pSelector)
        printf "Calling method -[%s %s]\n", (const char *)object_getClassName(*$_mci_pSelf), (SEL)method_getName($_mci_method)
    end
    
    # Display the arguments (remark: an ellipsis in an argument list is not included in
    # the return value of method_getNumberOfArguments)
    set $_mci_methodNbrArgs = (unsigned int)method_getNumberOfArguments($_mci_method) 
    # Begin with the third argument (the first are id and SEL)
    set $_mci_argIndex = 2
    while ($_mci_methodNbrArgs - $_mci_argIndex)
        # Refer to http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
        # for type encodings
        set $_mci_argType = (char *)method_copyArgumentType($_mci_method, $_mci_argIndex)
        set $_mci_methodArgIndex = $_mci_argIndex - 1
        
        # Object information
        if $_mci_argType[0] == '@'
            _getfunargadr _mci_pArg id $_mci_argIndex
            
            # Show a preview of the object description method. We can call Objective-C methods here, but only
            # if they have no object as parameter (otherwise we might create a recursion if mci is applied on
            # for inspecting a method we use here!). Otherwise, we must rely on C-functions
            set $_mci_argDescription = (const char *)[(NSString *)[*$_mci_pArg description] UTF8String]
            
            # Truncate the description if too long; we must work with a separate buffer
            set $_mci_cstrBufferTruncated = 0
            set $_mci_cstrBufferLength = (size_t)strlen($_mci_argDescription)
            if $_mci_cstrBufferLength > 200
                set $_mci_cstrBufferTruncated = 1
                set $_mci_cstrBufferLength = 200
            end
            
            # Allocate and fill the buffer
            set $_mci_cstrBuffer = (char *)calloc(sizeof(char) * ($_mci_cstrBufferLength + 1))
            # Trick: We do not use call here since it would print the result to the console!
            set $_mci_cstrBuffer = (char *)strncpy($_mci_cstrBuffer, $_mci_argDescription, 200)
            
            # Truncate all lines except the first one
            set $_mci_bufferCrPos = (char *)strchr($_mci_cstrBuffer, '\n')
            if $_mci_bufferCrPos
                set $_mci_cstrBufferTruncated = 1
                set *$_mci_bufferCrPos = '\0'
            end
            
            # Display the (maybe truncated) description
            if $_mci_cstrBufferTruncated
                printf "\tArg %2d: <%s: %p>: Description: %s (truncated: call 'po [%p description]' to get the full version)\n", $_mci_methodArgIndex, (const char *)object_getClassName(*$_mci_pArg), *$_mci_pArg, $_mci_cstrBuffer, *$_mci_pArg
            else
                printf "\tArg %2d: <%s: %p>: Description: %s\n", $_mci_methodArgIndex, (const char *)object_getClassName(*$_mci_pArg), *$_mci_pArg, $_mci_argDescription
            end
            
            # Done with the buffer
            call (void)free($_mci_cstrBuffer)
        # Int
        else
        if $_mci_argType[0] == 'i'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: int: (d)%d (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg
        # Short
        else
        if $_mci_argType[0] == 's'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: short: (d)%d (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg            
        # Long
        else
        if $_mci_argType[0] == 'l'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: long: (d)%d (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg
        # Long long
        else
        if $_mci_argType[0] == 'q'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: long long: (d)%d (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg
        # Unsigned int
        else
        if $_mci_argType[0] == 'I'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: unsigned int: (d)%u (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg
        # Unsigned short
        else
        if $_mci_argType[0] == 'S'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: unsigned short: (d)%u (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg
        # Unsigned long
        else
        if $_mci_argType[0] == 'L'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: unsigned long: (d)%u (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg
        # Unsigned long long
        else
        if $_mci_argType[0] == 'Q'
            _getfunargadr _mci_pArg $_mci_argIndex
            printf "\tArg %2d: unsigned long long: (d)%u (h)%X (o)%o\n", $_mci_methodArgIndex, *$_mci_pArg, *$_mci_pArg, *$_mci_pArg            
        # Character
        else
        if (const char *)strchr("cC", $_mci_argType[0])
            printf "\tArg %2d is a character\n", $_mci_methodArgIndex
        # Floating point value
        else
        if (const char *)strchr("fd", $_mci_argType[0])
            printf "\tArg %2d is an floating-point value\n", $_mci_methodArgIndex
        # Boolean value
        else
        if $_mci_argType[0] == 'B'
            printf "\tArg %2d is a boolean\n", $_mci_methodArgIndex
        # Pointer
        else
        if $_mci_argType[0] == '^'
            printf "\tArg %2d is a pointer\n", $_mci_methodArgIndex
        # C-string
        else
        if $_mci_argType[0] == '*'
            printf "\tArg %2d is a C-string\n", $_mci_methodArgIndex
        # C-array
        else
        if $_mci_argType[0] == '['
            printf "\tArg %2d is a C-array\n", $_mci_methodArgIndex
        # C-struct
        else
        if $_mci_argType[0] == '{'
            printf "\tArg %2d is a C-struct\n", $_mci_methodArgIndex
        # Union
        else
        if $_mci_argType[0] == '('
            printf "\tArg %2d is a union\n", $_mci_methodArgIndex
        # Class object
        else
        if $_mci_argType[0] == '#'
            printf "\tArg %2d is a class\n", $_mci_methodArgIndex
        # Selector
        else
        if $_mci_argType[0] == ':'
            printf "\tArg %2d is a selector\n", $_mci_methodArgIndex
        # Bit field
        else
        if $_mci_argType[0] == 'b'
            printf "\tArg %2d is a bit field\n", $_mci_methodArgIndex
        # Void
        else
        if $_mci_argType[0] == 'v'
            printf "\tArg %2d is void\n", $_mci_methodArgIndex  
        # Unknown
        else
            printf "\tArg %2d has an unknown type\n", $_mci_methodArgIndex
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        
        set $_mci_argIndex = $_mci_argIndex + 1
    end
end
document mci
end

# ----------------------------------------------------------------------------------------------
# Single argument extraction (only meant to be used when breaking on a function or method)
# ----------------------------------------------------------------------------------------------

define xa
    # Check the first argument
    if ($argc == 2 && "$arg0"[0] == '/')
        # No type argument to _getfunargadr. Only interested in the address, cast will be made
        # by x/<type> below
        _getfunargadr _xa_pArg $arg1
        x $arg0 $_xa_pArg
    else
        help xa
    end
end

document xa
Fetch a specific function argument, displaying it with the specified type. Add a * if you are
looking at arguments after the prologue
Usage: xa/TYPE INDEX
INDEX is 0-based. Do "help x" for more information about the types you can use.
end


