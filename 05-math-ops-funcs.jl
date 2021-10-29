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
