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

# Vectorized "dot" operators

# For every binary operation like `^`, there exists a 
# corresponding "dot" operation, for example, `.^`, that 
# _automatically_ defined to perform `^` element-by-element on 
# arrays. For example, `[1, 2, 3] ^ 3` is *not* defined since 
# there is no mathematical meaning to "cubing" a (non-square) 
# array. However, `[1, 2, 3] .^ 3` *is* defined as computing the 
# elementwise (or "vectorized") result; in other words, 
# `[1 ^ 3, 2 ^ 3, 3 ^ 3]`. Similarly for unary operations like 
# `!` or `√`, there is a corresponding operator like `.!` and 
# `.√` these corresponding operators apply the (basic) operator 
# elementwise.

[1, 2, 3] .^ 3

# Numeric comparisons

1 == 1
1 == 2
1 != 2
# Unclear how to enter alternate not equal operator
1 == 1.0
1 < 2
1.0 < 3
1 >= 1.0
# Unclear how to enter alternate greater than or equal to 
# operator
-1 <= 1
# Unclear how to enter alternate less than or equal to operator
-1 <= -1
-1 <= -2
3 < -0.5

# Remember that the comparison behavior of `NaN` may be 
# surprising

NaN == NaN
NaN != NaN
NaN < NaN
NaN > NaN

# The behavior of `NaN` can cause headaches when operating with
# arrays
[1 NaN] == [1 NaN]

# Julia provides additional functions to test numbers for 
# special values. These additional functions can be useful in 
# hash key comparisions

# x and y are identical
x = 3
y = 3.0
isequal(x , y)
isequal(3, nextfloat(y))
isfinite(x)
isfinite(-Inf)
isinf(x)
isinf(Inf)
isnan(x)
isnan(NaN)

# In particular, `isequal` considers all `NaN` values to be 
# equal.
isequal(Inf / Inf, 0 * -Inf)
isequal([1 NaN], [1 NaN])
isequal(NaN, NaN32)

# `isequal` *distinguishes* between signed and unsigned zero.
0.0 == -0.0
isequal(0.0, -0.0)

# Chaining comparisons

# Similar to Python, Julia supports chaining comparisons 
# arbitrarily.

1 < 2 <= 2 < 3 == 3 > 2 >= 1 < 3 != 5

# Note that chained operations use `&&` for scalar comparisons
# and `&` for elementwise comparisons. This definition allows
# one to use chained comparisons with arrays. For example, 
# `0 .< A .< 1` results in a boolean array whose elements are 
# true when the element of `A` is between 0 and 1.

# Chained comparisons include an optimization in that each value 
# in the chain is only computed once.
v(x) = (println(x); x)  # note the printing side effect

v(1) < v(2) <= v(3)

# Because of short-circuiting, not all values need to be 
# computed.
v(1) > v(2) <= v(3)

# BEWARE: the actual order of evaluations in a chained comparison
# is *undefined*. Consequently, it is strongly recommended that 
# expressions with side-effects (such as printing) *not* be used
# in chained comparisons. If side effects are required, then 
# explicitly using the short-circuit operator `&&` is 
# recommended.

# Operator precedence and associativity

# One can find the numerical precedence for operators using the 
# built-in function, `Base.operator_precedence`. Higher numbers
# have higher precedence. 

Base.operator_precedence(:+), Base.operator_precedence(:*), Base.operator_precedence(:.)

# An undefined operator
try
    Base.operator(:sin)
catch ex
    if isa(ex, UndefVarError)
        println(ex)
    end
end

# Note the necessary parentheses on `:(=)`
Base.operator_precedence(:+=), Base.operator_precedence(:(=))

# A symbol representing the operator associativity can also be 
# found by calling the built-in function 
# `Base.operator_associativity`.
Base.operator_associativity(:-), Base.operator_associativity(:+), Base.operator_associativity(:*)

# Invalid operators, such as :sin, return :none 
Base.operator_associativity(:⊗), Base.operator_associativity(:sin), Base.operator_associativity(:→)

# Again, numeric literal coefficients, e.g., `2x`, are treated 
# as multiplication with higher precedence than any binary 
# operator, with the exception of `^` where they have higher 
# precedence only as the exponent.

x = 3; 2x^2

x = 3; 2^2x

# Juxtaposition parses like a unary operator, which has the 
# same natural asymmetry around exponents: `-x^y` and `2x^y`
# parse as `-(x^y)` and `2(x^y)` whereas `x^-y` and `x^2y`
# parse as `x^(-y)` nad `x^(2y)`

# Numerical conversions

# Julia supports three forms of numerical conversion, which 
# differ in their handling of inexact conversions.

# Both `T(x)` and `convert(T, x)` converts `x` to a value of 
# type `T`.

# If `T` is a floating point type, the result is the nearest
# representable value, which could be positive or negative
# infinity.
# If `T` is an integer type, an `InexactError` is raised if `x`
# is not representable by `T`.

# The expression `x % T` converts an integer `x` to a value of
# integer type `T` congruent to `x modulo 2^n` where `n` is the
# number of bits in `T`. In other words, the binary 
# representation of `x` is truncated to fit in `T`.

# Finally, the 
# [Rounding functions](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Rounding-functions)
# take a type, `T` as an optional argument. For example, 
# `round(Int, x)` is a shorthand for `Int(round(x))`.

# Here are some examples:

Int8(127)
Int8(128)
Int8(127.0)
Int8(3.14)
Int8(128.0)

127 % Int8
128 % Int8
round(Int8, 127.4)
round(Int8, 127.6)

# See 
# [Conversion and Promotion](https://docs.julialang.org/en/v1/manual/conversion-and-promotion/#conversion-and-promotion)
# for how to define your own conversions and promotions.

# Rounding functions

# To nearest integer
round(1.4)
round(1.5)
round(1.6)

# Of type `T` (`Int8`) in our examples
round(Int8, 1.4)
round(Int8, 1.5)
round(Int8, 1.6)

# Round `x` toward `-Inf`
floor(1.4)
floor(1.5)
floor(1.6)

# Of type `T` (`Int8` in these examples)
floor(Int8, 1.4)
floor(Int8, 1.5)
floor(Int8, 1.6)

# Round `x` toward `+Inf`
ceil(1.4)
ceil(1.5)
ceil(1.6)

# Of type `T` (`Int8` in these examples)
ceil(Int8, 1.4)
ceil(Int8, 1.5)
ceil(Int8, 1.6)

# Round `x` toward 0
trunc(1.4)
trunc(1.5)
trunc(1.6)

# Of type `T` (`Int8` in these examples)
trunc(Int8, 1.4)
trunc(Int8, 1.5)
trunc(Int8, 1.6)
