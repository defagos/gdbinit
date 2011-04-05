# **********************************************************************************************
# Breakpoint management 
# **********************************************************************************************

define bpl
    info breakpoints
end
document bpl
List all breakpoints.
end

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
LOCATION may be a line number, function name, or "*" and an address.
With no arg, uses current execution address of selected stack frame.

To break on a symbol you must enclose symbol name inside "".
Example:
    bp "[NSControl stringValue]"
Or else you can use directly the break command (break [NSControl stringValue])

Do "help break" for more information.
end

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
LOCATION may be a line number, function name, or "*" and an address.
With no arg, uses current execution address of selected stack frame.

To break on a symbol you must enclose symbol name inside "".
Example:
    bpt "[NSControl stringValue]"
Or else you can use directly the tbreak command (tbreak [NSControl stringValue])

Do "help tbreak" for more information.
end

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
LOCATION may be a line number, function name, or "*" and an address. 
With no argument, clears all breakpoints in the line that the selected frame
is executing in.

To clear a breakpoint using its number, use the delete (d) command.

end

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
end

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
end
