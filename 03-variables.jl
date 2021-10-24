# Variables

## Basics

# Assign the value 10 to the variable x
x = 10

# Doing math with x's value
x + 1

# Reassign the value of x
x = 1 + 1

# You can assign values of **other** types to x
x = "Hello, Julia World!"

## Naming

x = 1.0
Z = "My string”"
y = -3
customary_phrase = "Hello, Julia World!"
DeclarationOfIndepdenceAutDeutsch = """Wir halten diese Wahrheiten für 
ausgemacht, daß alle Menschen gleich erschaffen worden, daß sie 
von ihrem Schöpfer mit gewissen unveräusserlichen Rechten begabt 
worden, worunter sind Leben, Freiheit und das Streben nach 
Glückseligkeit. Daß zur Versicherung dieser Rechte Regierungen 
unter den Menschen eingeführt worden sind, welche ihre gerechte 
Gewalt von der Einwilligung der Regierten herleiten; daß sobald 
einige Regierungsform diesen Endzwecken verderblich wird, es das 
Recht des Volkes ist sie zu verändern oder abzuschaffen, und eine 
neue Regierung einzusetzen, die auf solche Grundsätze gegründet, 
und deren Macht und Gewalt solchergestalt gebildet wird, als 
ihnen zur Erhaltung ihrer Sicherheit und Glückseligkeit am 
schicklichsten zu seyn dünket.
"""

# Unicode names are allowed

δ = 0.0001
hëllö = "hello"

# One can enter many Unicode symbols by typing the backslashed LaTeX symbol name followed by a tab
δ = 0.0001
π
pi

# Although one can redefine built-in symbols like `pi` and `sqrt` (but 
# only at the first use), it is not recommended. :)

# Variable names must begin with a letter (A-Z or a-z), an underscore, 
# or a subset of Unicode code points greater than 00A0; in particular, 
# the Unicode character categories 
#
# - Lu/Ll/Lt/Lm/Lo/Nl (letters)
# - Sc/So (currency and other symbols)
# - A few other letter-like characters (for example, a subset of the Sm 
#   math symbols)
#
# Subsequent characters may also include:
# - ! and digits (0-9 and other characters in categories Nd/No)
# - Other Unicode code points
#   - Diacritics
#   - Other modifying marks (categories Mn/Mc/Me/Sk)
#   - Some punctuation connectors (category Pc)
#   - Primes
#   - A few other characters

# Operators like `+` are also valid identifiers but are parsed specially.

# The only explicitly disallowed names for variables are the names of the 
# built-in [Keywords](https://docs.julialang.org/en/v1/base/base/#Keywords)

else = false

try = "No"

# Some Unicode characters are considered to be equivalent in identifiers. 
# Different ways of entering Unicode combining characters 
# (e. g., accents) are treated as equivalent.
#
# Specifically, the Unicode characters ε (U+025B) and µ (U+00B5) are 
# treated as equivalent to the corresponding Greek letters.

# Stylistic Conventions

# It is useful to adopt the following conventions:
#
# - Names of variables are lower case
# - Word separation can be indicated by underscores ('_') but the use of 
#   underscores is discouraged unless the name would be  hard to 
#   read otherwise
# - Names of `Types` and `Modules` begin with a capital letter and word
#   separation is shown with upper camel case (that is, PascalCase)
# - Names of `functions` and `macros` are in lower case, without underscores
# - Functions that write to their arguments have names that end in `!`. These
#   are sometimes called "mutating" or "in-place" functions because they are
#   are intended to produce changes in their arguments after the function is
#   called, not just return a value

# For more information about stylistic conventions, see the 
# [Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/#Style-Guide)
