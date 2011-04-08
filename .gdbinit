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
# Retrieving arguments (only meant to be used before a function prologue)
# ----------------------------------------------------------------------------------------------

# TODO: Currently only i386 (& iOS simulator). Must deal with 64 bits & iOS device as well!

define _getfunarg
if $argc == 2
    set $$arg0 = *(int *)($esp+4+4*$arg1)
else 
if $argc == 3
    set $$arg0 = *($arg1 *)($esp+4+4*$arg2)
else
    help _getfunarg
end
end
end

document _getfunarg
(For private use) Fetch function arguments (to be called before a function prologue)
Usage: _getfunarg OUTPUT_VAR_NAME [TYPE] INDEX
Sets the variable $OUTPUT_VAR_NAME to the INDEX-th argument of the function we're about to call
Uses type TYPE if present, otherwise 'int'
INDEX is 0-based
end

# ----------------------------------------------------------------------------------------------
# Selector call information (only meant to be used when breaking on objc_msgSend)
# ----------------------------------------------------------------------------------------------

define sci
if $argc == 0
    _getfunarg _sci_self id 0
    _getfunarg _sci_selector SEL 1   
    
    # Must be careful enough here NOT to use message sending (would be recursive!)
    printf "Message %s sent to <%s: %p>\n", $_sci_selector, (const char *)object_getClassName($_sci_self), $_sci_self
else
    help sci
end
end

document sci
Print information about the message and object passed to objc_msgSend
Usage: sci
This command is only meant to be used when breaking on objc_msgSend
end

# TODO: mci (method call information, x/y/z/w for argument types, up to 10), fci (function call information, x/y/z/w for argument types, up to 10)

# ----------------------------------------------------------------------------------------------
# Single argument extraction (only meant to be used when breaking on a function or method)
# ----------------------------------------------------------------------------------------------

define xa
# Check the first argument
if ($argc >= 1 && "$arg0"[0] != '/')
    help xa
else
if $argc == 2
    x $arg0 (int *)($esp+4+4*$arg1)
else
if ($argc == 3 && (int)strcmp("$arg1", "*") == 0)
    x $arg0 (int *)($ebp+8+4*$arg2)
else
    help xa
end
end
end
end

document xa
Fetch a specific function argument, displaying it with the specified type. Add a * if you are
looking at arguments after the prologue
Usage: xa/TYPE [*] INDEX
INDEX is 0-based. Do "help x" for more information about the types you can use.
end


