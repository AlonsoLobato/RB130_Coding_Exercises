## RB130 - Ruby Foundations: More Topics --> Easy 1

### Exercise 1: Enumerable Class Creation

Assume we have a Tree class that implements a binary tree.

```ruby
class Tree
  ...
end
```

A binary tree is just one of many forms of collections, such as Arrays, Hashes, Stacks, Sets, and more. All of these collection classes include the `Enumerable` module, which means they have access to an `each` method, as well as many other iterative methods such as `map`, `reduce`, `select`, and more.

For this exercise, modify the Tree class to support the methods of `Enumerable`. You do not have to actually implement any methods -- just show the methods that you must provide.

#### Solution

```ruby
class Tree
  include Enumerable

  def each(collection)
    idx = 0
    while idx < collection.size
      yield(collection[idx])
      idx += 1
    end
    collection
  end

  def <=>
    # code to determine what values are used for comparison
  end
end
```

##### Notes
- All we need to do is mixin the Enumerable module
- Define an each method that yield the elements of the collection one by one
- Define a comparison method
- After including the Enumerable module, the Tree#each and Tree#<=> methods will provide the underlying functionality necessary for the Enumerable instance methods to work on Tree objects.


### Exercise 2: Optional block

Write a method that takes an optional block. If the block is specified, the method should execute it, and return the value returned by the block. If no block is specified, the method should simply return the String 'Does not compute.'.

Examples:

```ruby
compute { 5 + 3 } == 8
compute { 'a' + 'b' } == 'ab'
compute == 'Does not compute.'
```

#### Solution

```ruby
def compute
  if block_given?
    yield
  else
    'Does not compute.' 
  end
end

compute { 5 + 3 } == 8           # true
compute { 'a' + 'b' } == 'ab'    # true
compute == 'Does not compute.'   # true
```

##### Further Exploration

Modify the compute method so it takes a single argument and yields that argument to the block. Provide at least 3 examples of calling this new version of compute, including a no-block call.

```ruby
def compute(arg)
  if block_given?
    yield(arg)
  else
    'Does not compute.' 
  end
end

p compute(5) { |arg| arg + 3 } == 8
p compute('a') { |arg| arg + 'b' } == 'ab'
p compute('a') == 'Does not compute.'
```

### Exercise 3: Find missing numbers

Write a method that takes a sorted array of integers as an argument, and returns an array that includes all of the missing integers (in order) between the first and last elements of the argument.

Examples:
```ruby
missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
missing([1, 2, 3, 4]) == []
missing([1, 5]) == [2, 3, 4]
missing([6]) == []
```

#### Solution

```ruby
def missing(array)
  full_array = (array[0]..array[-1]).to_a
  full_array - array
end
```

### Exercise 4: Divisors

Write a method that returns a list of all of the divisors of the positive integer passed in as an argument. The return value can be in any sequence you wish.

Examples: 
```ruby
divisors(1) == [1]
divisors(7) == [1, 7]
divisors(12) == [1, 2, 3, 4, 6, 12]
divisors(98) == [1, 2, 7, 14, 49, 98]
divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
```

#### Solution

```ruby
def divisors(int)
  (1..int).select { |num| int % num == 0 }
end
```

### Exercise 5: Encrypted Pioneers

The following list contains the names of individuals who are pioneers in the field of computing or that have had a significant influence on the field. The names are in an encrypted form, though, using a simple (and incredibly weak) form of encryption called Rot13.

Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unvog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu

Write a program that deciphers and prints each of these names .

** Rot-13, replaces a letter with the 13th letter after it in the alphabet

#### Solution

```ruby
def rot13_decipher(string)
  alphabet = ('a'..'z').to_a
  
  deciphered = string.chars.map do |char| 
    not_alpha = !alphabet.include?(char)
    upcased = char == char.upcase
    index = (alphabet.index(char.downcase) + 13) % 26 unless not_alpha
    
    if not_alpha
      char
    elsif upcased
      alphabet[index].upcase
    else
      alphabet[index]
    end
  end
  
  deciphered.join
end

p rot13_decipher('Nqn Ybirynpr')
p rot13_decipher('Tenpr Ubccre')
p rot13_decipher('Nqryr Tbyqfgvar')
p rot13_decipher('Nyna Ghevat')
p rot13_decipher('Puneyrf Onoontr')
p rot13_decipher('Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv')
p rot13_decipher('Wbua Ngnanfbss')
p rot13_decipher('Ybvf Unvog')
p rot13_decipher('Pynhqr Funaaba')
p rot13_decipher('Fgrir Wbof')
p rot13_decipher('Ovyy Tngrf')
p rot13_decipher('Gvz Orearef-Yrr')
p rot13_decipher('Fgrir Jbmavnx')
p rot13_decipher('Xbaenq Mhfr')
p rot13_decipher('Fve Nagbal Ubner')
p rot13_decipher('Zneiva Zvafxl')
p rot13_decipher('Lhxvuveb Zngfhzbgb')
p rot13_decipher('Unllvz Fybavzfxv')
p rot13_decipher('Tregehqr Oynapu')
```

### Exercise 6: Iterators: True for Any?

The `Enumerable#any?` method processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of true for any element, then `#any?` returns true. Otherwise, `#any?` returns false. Note in particular that `#any?` will stop searching the collection the first time the block returns true.

Write a method called `any?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `true` for any of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `true`.

If the Array is empty, `any?` should return `false`, regardless of how the block is defined.

Your method may not use any standard ruby method that is named `all?`, `any?`, `none?`, or `one?`.

Examples:
```ruby
any?([1, 3, 5, 6]) { |value| value.even? } == true
any?([1, 3, 5, 7]) { |value| value.even? } == false
any?([2, 4, 6, 8]) { |value| value.odd? } == false
any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
any?([1, 3, 5, 7]) { |value| true } == true
any?([1, 3, 5, 7]) { |value| false } == false
any?([]) { |value| true } == false
```

#### Solution
```ruby
def any?(arr)
  idx = 0
  while idx < arr.size
    return true if yield(arr[idx])
    idx += 1
  end
  false
end
```

#### Further Exploration
- The use of `each` in our method allows `any?` to work not only for arrays, but also for other collections like hashes

```ruby
def any?(coll)
  coll.each { |elem| return true if yield(elem) }
  false
end
```

### Exercise 7: Iterators: True for All?

`Enumerable#all?` processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of `true` for every element, then `#all?` returns `true`. Otherwise, `#all?` returns `false`. Note in particular that `#all?` will stop searching the collection the first time the block returns `false`.

Write a method called `all?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `true` for all of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `false`.

If the Array is empty, `all?` should return `true`, regardless of how the block is defined.

Your method may not use any standard ruby method that is named `all?`, `any?`, `none?`, or `one?`.

Examples:
```ruby
all?([1, 3, 5, 6]) { |value| value.odd? } == false
all?([1, 3, 5, 7]) { |value| value.odd? } == true
all?([2, 4, 6, 8]) { |value| value.even? } == true
all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
all?([1, 3, 5, 7]) { |value| true } == true
all?([1, 3, 5, 7]) { |value| false } == false
all?([]) { |value| false } == true
```

#### Solution
```ruby
def all?(collection)
  booleans = collection.map { |element| return false if !yield(element) }
  return true if !booleans.include? false 
end
```

```ruby
def all?(collection)
  collection.each { |element| return false unless yield(element) }
  true
end
```

### Exercise 8: Iterators: True for None?

`Enumerable#none?` processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns `true` for any element, then `#none?` returns `false`. Otherwise, `#none?` returns `true`. Note in particular that #`none?` will stop searching the collection the first time the block returns `true`.

Write a method called `none?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `false` for all of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `true`.

If the Array is empty, `none?` should return `true`, regardless of how the block is defined.

Your method may not use any of the following methods from the Array and Enumerable classes: `all?`, a`ny?`, `none?`, `one?`. You may, however, use either of the methods created in the previous two exercises.

Examples:
```ruby
  none?([1, 3, 5, 6]) { |value| value.even? } == false
  none?([1, 3, 5, 7]) { |value| value.even? } == true
  none?([2, 4, 6, 8]) { |value| value.odd? } == true
  none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
  none?([1, 3, 5, 7]) { |value| true } == false
  none?([1, 3, 5, 7]) { |value| false } == true
  none?([]) { |value| true } == true
```

#### Solution
```ruby
def none?(collection)
  collection.each { |element| return false if yield(element) }
  true
end
```

```ruby
def none?(collection, &block)
  !any?(collection, &block)
end
```
- `none?` is the opposite of `any?`
- so we can use the negation of `any?` but we have to explicitily pass the block to `any?`
- to do that, `none?` must require a block argument with an `&`. We then pass `&block` to `any?`, where it is treated as if the call to `any?` included the block.

### Exercise 9: Iterators: True for One?

`Enumerable#one?` processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of `true` for exactly one element, then `#one?` returns `true`. Otherwise, `#one?` returns `false`. Note in particular that `#one?` will stop searching the collection the second time the block returns `true`.

Write a method called `one?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `true` for exactly one of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `true` a second time.

If the Array is empty, `one?` should return `false`, regardless of how the block is defined.

Your method may not use any standard ruby method that is named `all?`, `any?`, `none?`, or `one?`.

Examples:
```ruby
p one?([1, 3, 5, 6]) { |value| value.even? } == true
p one?([1, 3, 5, 7]) { |value| value.odd? } == false
p one?([2, 4, 6, 8]) { |value| value.even? } == false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p one?([1, 3, 5, 7]) { |value| true } == false
p one?([1, 3, 5, 7]) { |value| false } == false
p one?([]) { |value| true } == false
```

#### Solution
```ruby
def one?(collection)
  booleans = collection.map { |element| yield(element) }
  return false if !booleans.include?(true) || booleans.count(true) > 1 
  true
end
```

### Exercise 10: Count Items

Write a method that takes an array as an argument, and a block that returns `true` or `false` depending on the value of the array element passed to it. The method should return a count of the number of times the block returns `true`.

You may not use `Array#count` or `Enumerable#count` in your solution.

Examples:
```ruby
count([1,2,3,4,5]) { |value| value.odd? } == 3
count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
count([1,2,3,4,5]) { |value| true } == 5
count([1,2,3,4,5]) { |value| false } == 0
count([]) { |value| value.even? } == 0
count(%w(Four score and seven)) { |value| value.size == 5 } == 2
```

#### Solution
```ruby
def count(arr)
  count = 0
  arr.each { |item| count +=1 if yield(item) }
  count
end
```

#### Further exploration
- same method without using each or loop, while, until
```ruby
def count(arr)
  arr.select { |item| yield(item) }.size
end
```
