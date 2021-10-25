# Integers and Floating-point Numbers

# Literal integers are represented in the standard manner

1
1234

# Default integer type depends on target system architecture

typeof(1)

# The Julia internal variable, `Sys.WORD_SIZE`, indicates target system 
# architecture

Sys.WORD_SIZE

# Larger integer literals that cannot be represented using only 32 bits
# but can be represented in 64 bits always create 64-bit integers, 
# regardless of the system type.

typeof(3_000_000_000)

# Unsigned integers are input and output using the `0x` prefix and 
# hexadecimal (base 16) digits (`0-9a-fA-F`). The size of the unsigned
# value determined by the number of hex digits used. This behavior is
# based on the observation that most use cases of hex literals use these
# digits to represent a fixed numeric byte sequence instead of just an
# integer value.

x = 0x1
typeof(x)

x = 0x123
typeof(x)

x = 0x1234567
typeof(x)

x = 0x123456789abcdef
typeof(x)

x = 0x1111_2222_3333_4444_5555_6666_7777_8888
typeof(x)

# Binary and octal literals are also supported. Users support the size of
# the values using the following "rules":
#
# - If leading digit (after the 'b', 'o' or 'x') is zero ('0'), the size
#   is the same size as the literal with a leading one ('1').
# - Otherwize, the size of the binary data is the minimal needed size for
#   the literal.
#
# Note that values that **cannot** be stored in a `UInt128` cannot be 
# written using such literals.

x = 0b10
typeof(x)

x = 0o010
typeof(x)

x = 0x0000_0000_0000_0000_1111_2222_3333_4444

# Binary, octal and hexadecimal literals may be prepended by a negative 
# sign ('-'). This results in the value being an unsigned integer of the
# same size as the unsigned literal but the value is the two's complement
# of the unsigned value. That is, imagine that the system calculates the 
# the unsigned value first and then takes the two's complement of that
# value as the value of the number.

0x2
-0x2

0x0002
-0x0002

# The minimum and maximum representable values of primitive numeric types 
# such as integers are given by the `typemin` and `typemax` functions.

(typemin(Int32), typemax(Int32))

for T in [Int8, Int16, Int32, Int64, Int128, 
          UInt8, UInt16, UInt32, UInt64, UInt128]
    println("$(lpad(T, 7)): [$(typemin(T)), $(typemax(T))]")
end

# Overflow behavior

# In Julia, exceeding the maximum representable value of a given type 
# results in wrap-around behavior.

x = typemax(Int64)

x + 1

x + 1 == typemin(Int64)

# In applications where overflow is possible, one **must** explicitly 
# check for wrap-around producing overflow. If this behavior is **not**
# desired, use `BigInt` in the `Arbitrary Precision Arithmetic` package 
# is recommended instead.
#
# Here is an example of checking:

10^19

10^19 < 0

big(10)^19

# Division errors

# Integer division, the `div` function, has two exceptional cases:
#
# - Dividing by zero
# - Dividing the lowest negative number in the type, `typemin`,
#   by -1.
#
# Both of these cases throw a `DivideError`. 
#
# The remainder and modulus, `rem` and `mod`, respectively, throw a
# `DivideError` when their second argument is zero ('0').

function try_divide_error(f, numerator, denominator)
    try
        println("$(f)($(numerator), $(denominator))")
        f(numerator, denominator)
    catch ex
        if isa(ex, DivideError)
            println("`DivideError` thrown")
        end
    end
end

try_divide_error(div, 1, 0)
try_divide_error(div, typemin(Int64), -1)
try_divide_error(rem, 13, 0)
try_divide_error(rem, 17, 0)