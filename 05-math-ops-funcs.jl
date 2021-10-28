# Mathematical operations and elementary functions

# Julia provides a typical set of operations and portable, 
# efficient implementations of standard mathematical functions.

# Arithmetic operations

x = 2.718
y = 1.414

+x
-x
x + y
x - y
x * y
x / y
x * y

m = 3
n = 7
m % n  # same as rem(m, y)

1 + 2 + 3

1 - 2

3 * 2 / 12

# When used in multiplication, `false` acts as a _strong zero_.

NaN * false

false * Inf

# This use of a _strong zero_ is useful for preventing the 
# propogation of `NaN` values in quantities that are known to be
# zero. See [Knuth (1992)](https://arxiv.org/abs/math/9205211)
# for details.

# Boolean operators

# The following _Boolean operators_ are supported on values of 
# type, `Bool`.

x = true
y = false

!x
x && y
x || y

x & y
x | y

# The operators `&&` and `||` are short-circuiting. The operators 
# `&` and `|` *do not* short-circuit.

# Remember that `Bool` is an *integer* type so all the usual 
# promotion rules and numeric operators apply to these values.

x + 3

# Bitwise operators

# The following _bitwise operators_ are supported on all 
# primitive integer types (not floating point?)

j = 0x5ca1_ab1e  # UInt32
typeof(j)
k = 0o7070  # UInt16
typeof(k)
l = 0b1001_1001  # UInt8
typeof(l)

~j
k & l
j | l
l ⊻ k
j >>> 8
k >> 3
l << 2

~123
123 & 234
123 | 234
123 ⊻ 234
xor(123, 234)
~UInt32(123)
~UInt8(123)

# Updating operators

# Every binary arithmetic and bitwise operator also has an 
# updating version that assigns the result of the operation
# back into its left operand. (Similar to other languages.)

x = 1
x += 3
x

# Because the updating operator may generate a value of a 
# *different* type than the left-hand operand and because the 
# updating operators rebind the result to the left-hand operand,
# the type of the left-hand operand may *change*.

x = 0x01
typeof(x)

x *= 2
typeof(x)
