# elixir-learnings --> Notes

#### Assignments

`=` symbol is a "match operator" and not an assignment operator.

The way to think about `a = 1` is that Elixir is trying to make left hand equal to right hand.

```
a = 1 -> ok
1 = a -> ok
2 = a  -> match error
```

Pattern matching = A pattern (left side) is matched if the values (the right side) have the same structure and if each term in the pattern can be matched to the corresponding term in the values.

examples:
```elixir
list = [1, 2, [3, 4, 5]]
[a, b, c] = list

a is 1
b is 2
c is [3 ,4 ,5]
```

Ignoring values

Values can be ignored with an underscore (\_), we can use it if we do not need to capture value during a match. It accepts any value for a match. Eg:

```
[1, _, _] = [1, 2, 3]
[1, _, _] = [1, "cat", "dog"]
```

#### Variable binding in matching

Once variable is bound to a value in matching process, it keeps that value for the remainder of the match

```
[a, a] = [1, 1]
[b, b] = [1, 2]  # match err. Why? First expression is okay because `a` is matched with `1` and then same value is used to match second `1`. For second expression, `b` matches `1` and then tries to match `2` but it cannot have two different values
```

Variable can be bound to a new value in subsequent matching no problem

```
a = 1
[1, a, 3] = [1, 2, 3] # this is ok even if first match was a =1 and second match is a = 2
```

### Immutability (ch3)

All data is immutable, if we need to modify [1, 2, 3] by adding 100 to each value, we produce a copy. Copy example:

```
list1 = [3, 2, 1]
list2 = [4 | list1] # this is using [head | tail] operator
```

GC problems addressed somewhat by each process having its own heap, and thus by dividing this into multiple smallish heaps GC runs faster, if process terminates before heap becomes full, all data is discarded and no GC is even required.

### Basics

Atoms.
They are constants that represent something's name. An Atom's name is its value, two atoms with the same name will always compare as being equal.

```
:fred :is_binary? :<> :"somethingfunc/2" #etc
```

Tuples.

Ordered collection of values, typically two to four elements, any more and you want maps or structs

{ 1, 2 } { :ok, 42, "next"}

Common practice is to write tuples in matches were we assume success

{:ok, file} = File.open("mix.exs")

Lists.

They are more like linked lists than arrays. Easy to traverse in linear fashion but expensive to access in random order.

List operators:

- concat [1,2,3] ++ [4,5,6]
- difference [1,2] -- [2,5]
- membership 1 in [1,2,3,4] # -> true

Maps.

Collection of key/value pairs

```
%{ key => value, key => value }
states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
```

#### "with" expression

Used to basically declare variables that do not leak outside of their local scope, also helps with pattern matching error handling somehow? need to check it out further (ch4 p38)

#### Functions

Anonymous fn example

```
sum = fn (a, b) -> a + b end
sum.(3,4)
```

What is the dot (.) doing there? This is function invocation for anonymous function, for named function we dont need a dot.

Pattern matching allows fairly complex function behavior which can be handy. This function for example swaps the elements in a tuple

`swap = fn {a, b} -> {b, a}`
`swap.( { 6, 8 } )` would return `{8, 6}`

##### Multiple bodies of a function

Fn with multi body example:

```elixir
  handle_open = fn
    {:ok, file} -> "Read data: #{IO.read(file, :line)}"
    {_, error}  -> "Error: #{:file.format_error(error)}"
  end
```

How does this work, we have two function bodies. No1 matches ":ok" atom and a "file", which basically will fail if first element is not :ok. So it will bump down to second body which matches anything on the first element due to underscore, and then matches error with the second element.

Functions in Elixir have closures, inner functions remember the bindings of variables in the scope in which they are defined.
