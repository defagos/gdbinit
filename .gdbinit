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
List all breakpoints.
end

# ----------------------------------------------------------------------------------------------
# Normal breakpoints
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
Set breakpoint.
Usage: bp [LOCATION]
LOCATION may be a line number, function name (before function prolog), or "*" 
and an address (after function prolog).

With no arg, uses current execution address of selected stack frame.

To break on a symbol you must enclose symbol name inside "".
Example:
    bp "[NSControl stringValue]"
Or else you can use the break command directly (break [NSControl stringValue])

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
Set temporary breakpoint.
Usage: bpt [LOCATION]
LOCATION may be a line number, function name (before function prolog), or "*" 
and an address (after function prolog).

With no arg, uses current execution address of selected stack frame.

To break on a symbol you must enclose symbol name inside "".
Example:
    bpt "[NSControl stringValue]"
Or else you can use the tbreak command directly (tbreak [NSControl stringValue])

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
Set a read/write breakpoint on EXPRESSION, e.g. *address.
Usage: bpm EXPRESSION
A memory breakpoint stops execution of your program whenever the value of
an expression is either read or written.

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
Set a hardware assisted breakpoint.
Usage: bph [LOCATION]
LOCATION may be a line number, function name (before function prolog), or "*" 
and an address (after function prolog).

To break on a symbol you must enclose symbol name inside "".
Example:
    bph "[NSControl stringValue]"
Or else you can use the hb command directly (hb [NSControl stringValue])

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
Clear breakpoint.
Usage: bpc [LOCATION]
LOCATION may be a line number, function name (before function prolog), or "*" 
and an address (after function prolog).

With no argument, clears all breakpoints in the line that the selected frame
is executing in.

To clear a breakpoint using its number, use the delete (d) command instead.

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

# ----------------------------------------------------------------------------------------------
# Globals
# ----------------------------------------------------------------------------------------------

set unwindonsignal on

# ----------------------------------------------------------------------------------------------
# Retrieving arguments before a function prolog
# ----------------------------------------------------------------------------------------------
# See http://www.clarkcox.com/blog/2009/02/04/inspecting-obj-c-parameters-in-gdb/

# TODO: Currently only i386 (& iOS simulator). Must deal with 64 bits & iOS device as well!

define _getfunargbp
if $argc == 2
    set $$arg0 = *(long*)($esp+4+4*$arg1)
else 
if $argc == 3
    set $$arg0 = *($arg1*)($esp+4+4*$arg2)
else
    help _getfunargbp
end
end
end
document _getfunargbp
Fetches function arguments (to be called before a function prolog)
Usage: _getfunargbp NAME [TYPE] INDEX
Sets the variable $NAME to the INDEX-th argument of the function we're about to call
Uses type TYPE if present, otherwise 'long'
<index> is 0-based
end

# ----------------------------------------------------------------------------------------------
# Retrieving arguments after a function prolog
# ----------------------------------------------------------------------------------------------
# See http://www.clarkcox.com/blog/2009/02/04/inspecting-obj-c-parameters-in-gdb/

# TODO: Currently only i386 (& iOS simulator). Must deal with 64 bits & iOS device as well!

define _getfunargap
if $argc == 2
    set $$arg0 = *(long*)($ebp+8+4*$arg1)
else 
if $argc == 3
    set $$arg0 = *($arg1*)($ebp+8+4*$arg2) 
else
    help _getfunargap
end
end
end
document _getfunargap
Fetches function arguments (to be called after a function prolog)
Usage: _getfunargap NAME [TYPE] INDEX
Sets the variable $NAME to the INDEX-th argument of the function we're about to call
Uses type TYPE if present, otherwise 'long'
<index> is 0-based
end

# ----------------------------------------------------------------------------------------------
# Selector call information (to be used before the prolog of objc_msgSend)
# ----------------------------------------------------------------------------------------------
define scibp
if $argc == 0
    _getfunargbp _scibp_self id 0
    _getfunargbp _scibp_selector SEL 1
    # Must be careful enough here NOT to use message sending (would be recursive!)
    printf "Message %s sent to %p\n", $_scibp_selector, $_scibp_self
else
    help scibp
end
end
document scibp
Print information about the message and object passed to objc_msgSend. Must be called
when breaking on objc_msgSend (before its prolog)
end

# ----------------------------------------------------------------------------------------------
# Selector call information (to be used after the prolog of objc_msgSend)
# ----------------------------------------------------------------------------------------------
define sciap
if $argc == 0
    _getfunargap _sciap_self id 0
    _getfunargap _sciap_selector SEL 1
    # Must be careful enough here NOT to use message sending (would be recursive!)
    printf "Message %s sent to %p\n", $_sciap_selector, $_sciap_self
else
    help sciap
end
end
document sciap
Print information about the message and object passed to objc_msgSend. Must be called
when breaking on objc_msgSend (after its prolog)
end

# TODO: mci (method call information), fci (function call information)


# $eip == objc_msgSend
