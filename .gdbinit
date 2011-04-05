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
    if ($argc != 0 && $argc != 1)
        help bp
    else
        if $argc == 1
            break $arg0
        else
            break
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

define bpc 
    if ($argc != 0 && $argc != 1)
        help bpc
    else
        if $argc == 1
            clear $arg0
        else
            clear
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
    if ($argc != 0 && $argc != 1)
        help bpe
    else
        if $argc == 1
            enable $arg0
        else
            enable
        end
    end
end

document bpe
Enable some breakpoint (all if none specified)
Usage: bpe [NUM]

end

# ----------------------------------------------------------------------------------------------

define bpd
    if ($argc != 0 && $argc != 1)
        help bpd
    else
        if $argc == 1
            disable $arg0
        else
            disable
        end
    end
end
document bpd
Disable some breakpoint (all if none specified)
Usage: bpd [NUM]
end
