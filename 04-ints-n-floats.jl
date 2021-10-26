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

# Floating-point

1.0

1.

0.5

.5

1e10

2.5e-4

# The previous results are all of type `Float64.` Julia also supports 
# `Float32` (single-point precision). Literal `Float32` values can be 
# created by writing the literals using scientific notation but with
# the letter 'f' (lower-case only) replacing both 'e' and 'E'.

x = 0.5f0
typeof(x)

2.5f-4

# Other values can be easily converted to `Float32`

x = Float32(-1.5)
typeof(x)

# Hexadecimal floating-point literals are also valid, but only as `Float64`
# values, with a 'p' preceding the base-2 exponent. (Note that one **must**
# understand the binary representation of `Float64` values to understand
# the following code. Otherwise, "trust me." :) )

0x1p0

0x1.8p3

x = 0x.4p-1
typeof(x)

# The underscore, '_', can be used as a digit separator for different 
# literals.

10_000

0.000_000_005

0xdead_beef

0b1011_0010

# Floating-point zero

# Floating-point numbers have **two zeros**, positive zero and negative 
# zero. The compare equal to each other, but have **different** binary
# representations. The different binary representations can be seen using
# the `bitstring` function.

0.0 == -0.0

bitstring(0.0)

bitstring(-0.0)

# Special floating-point values

# Three specified floating-point values that do not correspond to **any**
# value on the real-number line: `Inf`, `-Inf`, and `NaN`. 
#
# As expected, `Inf` is a value greater than all finite floating-point 
# values. Similarly, `-Inf` is a value less than all finite floating-point
# values. Finally, `NaN` is a value not equal to **any** other value 
# including itself.

1 / Inf

1 / 0

-5 / 0

0.000001 / 0

0 / 0

500 + Inf

500 - Inf

Inf + Inf

Inf - Inf

Inf * Inf

Inf / Inf

0 * Inf

# The `typemin` and `typemax` functions also apply to floating-point 
# numbers

(typemin(Float16), typemax(Float16))
(typemin(Float32), typemax(Float32))
(typemin(Float64), typemax(Float64))

# Machine epsilon

# Most real numbers **cannot** be represented exactly with floating-point 
# numbers. Consequently, for many purposes, it is important to know the
# distance between two adjacent representable floating-point numbers,
# which is often known as _machine epsilon_.

# Julia provides `eps`, a function which gives the distance between 1.0
# and the next **larger** representable floating-point value.

eps(Float32)

eps(Float64)

eps()  # Same as `eps(Float64)`

# The values returned by the `eps` function are 2.0^-23 and 2.0^-52 as 
# `eps(Float32)` and `eps(Float64)`, respectively.
#
# The `eps()` function also accepts a floating-point number as an argument.
# With a floating-point argument, `eps()` returns the absolute value of 
# the difference between the argument and the next available representable
# floating point number. In other words, `eps(x)` yields a value of the 
# same type as `x` that is equal to `x + eps(x)`.

eps(1.0)
eps(1000.)
eps(1e-27)
eps(0.0)

eps(1.0f0)
eps(1000.f0)
eps(1f-27)
eps(0.0f0)

# The distance between two adjacent representable floating-point numbers 
# is **not** constant, but is smaller for smaller values and larger for
# larger values. In other words, the representable floating-point numbers
# are densest in the real-number line near zero, and grow sparser 
# exponentially as one moves farther away from zero.

# Julia also provides the `nextfloat` and `prevfloat` functions which 
# return the next largest or next smallest representable floating-point
# number to the argument, respectively.

function show_sequential_floats(x)
    println(prevfloat(x))
    println(x)
    println(nextfloat(x))

    println(bitstring(prevfloat(x)))
    println(bitstring(x))
    println(bitstring(nextfloat(x)))
end

show_sequential_floats(1.25f0)
show_sequential_floats(1.25)
show_sequential_floats(1.24)

# These examples demonstrate that adjacent representable floating-point 
# numbers also have adjacent binary representations.

# Rounding modes

# If a number does not have an exact floating-point representation, it must 
# be rounded to an appropriate representable value. However, one has 
# control over this rounding using the rounding modes described in the 
# [IEEE 754 standard](https://en.wikipedia.org/wiki/IEEE_754-2008).
#
# The default mode used is always 
# [RoundNearest](https://docs.julialang.org/en/v1/base/math/#Base.Rounding.RoundNearest)
# which rounds to the nearest available representable value, with ties 
# rounded towards the nearest value with an **even** least significant bit.