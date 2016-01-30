# Boolean values #

`#f` is false, and every other value is true. The default truth value is `#t`.

# Builtin special forms #
| **signature** | **description** |
|:--------------|:----------------|
| `(quote val)` |                 |
| `(cond (cond1 do1 do2 ...) (cond2 do1 do2 ...) ...)` |                 |
| `(if cond then else)` |                 |
| `(and ...)`   |                 |
| `(or ...)`    |                 |
| `(while cond . bodies)` |                 |
| `(lambda args . bodies)` | `args` is a list or dotted list. |
| `(begin ...)` |                 |
| `(set! sym expr)` | set lexically-bound variable (sym is not evaluated) |
| `(trycatch body func)` | if an exception occurs evaluating `body`, `func` is invoked with the exception as its argument |
| `(for lo hi (lambda (n) body))` | fast bounded iteration. the supplied function is invoked successively for n from lo to hi, inclusive. |
| `(prog1 expr1 expr2)` | evaluate expr1 and expr2 in order, then return the result of expr1 |

# Standard builtin functions #

## Predicates ##

`eq?, eqv?, equal?, atom?, not, null?, symbol?, number?, boolean?, bound?, pair?, builtin?, vector?, fixnum?, procedure?`

## Lists ##

`cons, list, car, cdr, set-car!, set-cdr!`

## Execution ##

`eval, apply, return`

## Arithmetic ##

`+, -, *, /, div, div0, mod, mod0, <, =`

## Sequences ##

`vector, aref, aset!, length`

# Nonstandard builtin functions #
| **signature** | **description** |
|:--------------|:----------------|
| `(raise val)` | raise an exception (any value) |
| `(compare a b)` | perform an ordered comparison of any two values. returns -1, 0, or 1, for a<b, a==b, and a>b, respectively |
| `lognot`, `logand`, `logior`, `logxor`, `ash` | bitwise not, and, or, xor, bit shift |

# Standard library #

## Naming ##

`label, define, define-macro, let, let*, letrec`

## Lists ##

`map, append, append!, assoc, assv, assq, member, memv, memq, caar, cadr, cdar, cddr, caaar, caadr, cadar, caddr, cdaar, cdadr, cddar, cdddr, every, any, list?, list-tail, list-ref, list*, last-pair, lastcdr, length=, length>, map!, mapcar, for-each, filter, count, foldr, foldl, reverse, reverse!, copy-list, copy-tree, map-int, iota, revappend, nreconc, delete-duplicates`

## Predicates ##

`char?, array?, /=, >, <=, >=, self-evaluating?, negative?, positive?, zero?, even?, odd?`

## Control ##

`when, unless, dotimes, do, case, error, throw, catch, unwind-protect, time, assert`

## Misc ##

`backquote, macroexpand-1, macroexpand, list->vector, vector->list, vector.map, identity, 1+, 1-, abs, random, trace, untrace, traced?`

# Value constructors #
| **signature** | **description** |
|:--------------|:----------------|
| `(cons a b)`  |                 |
| `(list ...)`  |                 |
| `(vector ...)` |                 |
| `(vector.alloc size [init])` | make a vector of the given size, optionally initializing every element to the given value |
| `(array ctype [elts ...])` | make primitive (unboxed) array |
| `(c-value ctype [init])` | make c-value of the given type, optionally initialize |
| `(table key val key val ...)` |                 |

The following cvalue constructors are also available: `int8, uint8, int16, uint16, int32, uint32, int64, uint64, byte, wchar, long, ulong, float, double`

# Environment #
| **signature** | **description** |
|:--------------|:----------------|
| `(symbol str)` | create an interned symbol with the given name |
| `(gensym)`    | create a unique symbol |
| `(symbol-syntax sym)` | get the expander for a symbol, or nil if none |
| `(set-syntax! sym function)` | set the macro expander function for the given head symbol |
| `(top-level-value sym)` | get the top-level binding of a symbol. the argument is evaluated. |
| `(set-top-level-value! sym val)` | set top-level binding. both arguments are evaluated. |
| `(environment)` | get a list of bound global symbols |
| `(constant? x)` | determine whether an expression is a constant |
| `(load filename)` | read and evaluate all expressions in a file (filename is a string) |
| `(exit [code])` | quit interpreter |


# Global variables #
| **name** | **meaning** |
|:---------|:------------|
| `*install-dir*` | location of femtoLisp executable |
| `*argv*` | list of command-line arguments (as strings) |
| `*os-name*` | symbol indicating the platform where we're running |
| `*print-pretty*` | enable pretty printing, default is #t |
| `*print-width*` | number of columns used in prettyprinting, default 80 |
| `*print-readably*` | print values so they can be read back in, default #t |
| `*stdin*, *stdout*, *stderr*` | io streams for standard descriptors |
| `*input-stream*, *output-stream*` | current default io streams |
| `*directory-separator*` | the directory separator on the local platform |
| `*linefeed*` | the line terminator on the local platform |


# Strings #

| **signature** | **description** |
|:--------------|:----------------|
| `(string? x)` |                 |
| `(string a b ...)` | append/construct |
| `(string.inc str index [nchars])` | increment a byte index by n characters (default 1) |
| `(string.dec str index [nchars])` |                 |
| `(string.count str i j)` | # of chars between 2 byte offsets |
| `(string.width str)` | # columns when printed |
| `(string.char str i)` | char at byte offset |
| `(string.sub str i j)` | substring between 2 bytes offsets |
| `(string.split str sep-str)` | split string on characters in sep-str string |
| `(string.trim s at-start at-end)` | remove given chars from beginning and end of string |
| `(string.reverse s)` |                 |
| `(string.find s str|char [start offset])` |                 |
| `(string.map f str)` |                 |
| `(string.encode wchar-array)` | convert to UTF8 |
| `(string.decode str)` | convert to UCS  |
| `(string.tail str n)` | drop n characters from the front of str |
| `(number->string n [radix])` |                 |
| `(string.lpad str n c)` | pad string to length n by adding character c on the left. |
| `(string.rpad str n c)` | pad string to length n by adding character c on the right. |
| `(string.rep s k)` | build a string of k copies of s |
| `(string.join strlist sep)` | join strings from a list, with the given separator between them |
| `(char.upcase c)` |                 |
| `(char.downcase c)` |                 |


# Hash Tables #
Hash tables use `equal` to compare keys.

| **signature** | **description** |
|:--------------|:----------------|
| `(table? x)`  |                 |
| `(put! table key value)` | add or update key |
| `(get table key [default])` | look up key. if the key is not found, an exception is thrown unless a default value is specified, in which case it is returned. |
| `(has table key)` | query whether table contains key |
| `(del! table key)` | remove a key, throwing an exception if not found |
| `(table.foldl f zero table)` | call (f k v X) for successive key/value pairs, where X is the previous result, starting at the given zero |
| `(table.keys table)` |                 |
| `(table.pairs table)` |                 |
| `(hash val)`  | compute a numeric hash for a value |


# IO Streams #

| done? | **signature** | **description** |
|:------|:--------------|:----------------|
|Y      | `(iostream? x)` |                 |
|Y      | `(read [stream])` | returns `#f` on end-of-file. call `io.eof?` after `read` to distinguish this from reading the false value. |
|Y      | `(print val ...)` |                 |
|Y      | `(io.print stream val ...)` |                 |
|Y      | `(princ val ...)` |                 |
|Y      | `(io.princ stream val ...)` |                 |
|Y      | `(file name [mode options...])` | mode options can be `:read, :write, :append, :create, :truncate` |
|Y      | `(buffer)`    | create an in-memory IO stream |
|       | `(stream str)` |                 |
|Y      | `(io.eof? s)` |                 |
|Y      | `(io.write s cvalue)` |                 |
|Y      | `(io.read s ctype)` |                 |
|Y      | `(io.close s)` |                 |
|       | `(io.copy to from [nbytes])` |                 |
|       | `(io.copyuntil to from byte)` |                 |
|Y      | `(io.flush s)` |                 |
|       | `(io.pos s [new-pos])` |                 |
|       | `(io.seek s offset)` |                 |
|       | `(io.seekend s)` |                 |
|       | `(io.trunc s size)` |                 |
|Y      | `(io.getc s)` |                 |
|Y      | `(io.putc c)` |                 |
|Y      | `(io.tostring! s)` | destructively convert a buffer to a string |
|Y      | `(io.readuntil s delim)` |                 |
|Y      | `(io.readline s)` |                 |
|       | `(io.readlines s)` |                 |
|       | `(io.readall s)` |                 |


# Paths #
| done? | **signature** | **description** |
|:------|:--------------|:----------------|
|       | `(path.combine ...)`|                 |
|       | `(path.parts p)` |                 |
|       | `(path.absolute p)` |                 |
|       | `(path.simplify p)` |                 |
|       | `(path.tempdir)` |                 |
|       | `(path.tempname)` |                 |
|       | `(path.homedir [user])` |                 |
|Y      | `(path.cwd [new-cwd])`|                 |


# Time and date #
| done? | **signature** | **description** |
|:------|:--------------|:----------------|
|Y      | `(time.now)`  |                 |
|       | `(time.parts t)` |                 |
|       | `(time.fromparts v)`|                 |
|Y      | `(time.string t)`|                 |
|       | `(time.fromstring s)`|                 |


# System #
| done? | **signature** | **description** |
|:------|:--------------|:----------------|
|Y      | `(os.getenv var)` |                 |
|Y      | `(os.setenv var [val])` |                 |


# Numbers #
| **signature** | **description** |
|:--------------|:----------------|
| `(truncate x)` | convert to integer of appropriate type |
| `(fixnum x)`  | convert to fixnum |
| `(integer? x)` | is x an exact integer? |
| `(integer-valued? x)` | is x integer valued? |
| `(rand)`      | get a random fixnum |
| `(rand.uint32)` |                 |
| `(rand.uint64)` |                 |
| `(rand.double)` |                 |
| `(rand.float)` |                 |


# C values #
| **signature** | **description** |
|:--------------|:----------------|
| `(sizeof x)`  | size in bytes of c value or type |
| `(typeof x)`  | symbolic representation of the type of any value. returns one of the symbols `pair, fixnum, symbol, vector, boolean, null, builtin,` or `function`, or a cvalue type expression. |
| `(copy x)`    | copy a mutable c value |
| `(plain-old-data? x)` | tells whether x is a plain binary data object (somtimes called a blittable object) |
| `(dump x [offset [nbytes]])` | print a hex dump of a plain-old-data value |

# Functions #
| **signature** | **description** |
|:--------------|:----------------|
| `(function str vals env)` | create a function object from the given bytecode string, vector of referenced values, and closed environment. femtolisp may crash if any of these is malformed. |
| `(function:code f)` | get the bytecode string for a function |
| `(function:vals f)` | get a function's vector of referenced values |
| `(function:env f)` | get a function's closed environment |
| `(compile lambda-expr)` | compile a lambda expression into equivalent bytecode |
| `(disassemble f)` | print an easier-to-read representation of a compiled function |