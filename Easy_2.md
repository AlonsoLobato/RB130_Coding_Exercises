## RB130 - Ruby Foundations: More Topics --> Easy 2

### Exercise 1: From-To-Step Sequence Generator

The `Range#step` method lets you iterate over a range of values where each value in the iteration is the previous value plus a "step" value. It returns the original range.

Write a method that does the same thing as `Range#step`, but does not operate on a range. Instead, your method should take 3 arguments: the starting value, the ending value, and the step value to be applied to each iteration. Your method should also take a block to which it will yield (or call) successive iteration values.

Example:
```ruby
step(1, 10, 3) { |value| puts "value = #{value}" }

value = 1
value = 4
value = 7
value = 10
```

What do you think would be a good return value for this method, and why?

#### Solution
```ruby
def step(start_val, end_val, step_val)
  arr = (start_val..end_val).to_a
  idx = 0
  while idx < arr.size
    yield(arr[idx])
    idx += step_val
  end
end
```

```ruby
def step(start_val, end_val, step_val)
  while start_val <= end_val
    yield(start_val)
    start_val += step_val
  end
end
```

### Exercise 2: Zipper

The `Array#zip` method takes two arrays, and combines them into a single array in which each element is a two-element array where the first element is a value from one array, and the second element is a value from the second array, in order. For example: `[1, 2, 3].zip([4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]`.

Write your own version of `zip` that does the same type of operation. It should take two Arrays as arguments, and return a new Array (the original Arrays should not be changed). Do not use the built-in `Array#zip` method. You may assume that both input arrays have the same number of elements.

#### Solution

```ruby
def zip(arr1, arr2)
  new_arr = []
  idx = 0
  while idx < arr1.size do
    new_arr << [arr1[idx], arr2[idx]]
    idx += 1 
  end
  new_arr
end

zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
```

```ruby
def zip(arr1, arr2)
  arr1.each_with_index.with_object([]) do |(item, idx), arr| 
    arr << [item, arr2[idx]]
  end
end
```

### Exercise 3: Map

The `Enumerable#map` method iterates over the members of a collection, using the associated block to perform some sort of operation on each collection member. The returned values from the block are then built up into an Array that is then returned to the caller. Note in particular that every time `#map` yields to the block, it obtains just one value. That value may be a complex value - it may even be another collection - but it is nevertheless just one value. Thus, `#map` returns an Array that has the same number of elements that the original collection had.

Write a method called `map` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return a new Array that contains the return values produced by the block for each element of the original Array.

If the Array is empty, `map` should return an empty Array, regardless of how the block is defined.

Your method may use `#each`, `#each_with_object`, `#each_with_index`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
map([]) { |value| true } == []
map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]
```

#### Solution

```ruby
def map(arr)
  new_arr = []
  arr.each { |item| new_arr << yield(item) }
  new_arr
end
```

```ruby
def map(arr)
  arr.each_with_object([]) { |item, new_arr| new_arr << yield(item)}
end
```

### Exercise 4: Count

The `Enumerable#count` method iterates over the members of a collection, passing each element to the associated block. It then returns the number of elements for which the block returns a truthy value.

Write a method called `count` that behaves similarly for an arbitrarily long list of arguments. It should take 0 or more arguments and a block, and then return the total number of arguments for which the block returns `true`.

If the argument list is empty, count should return 0.

Your method may use `#each`, `#each_with_object`, `#each_with_index`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
count(1, 3, 6) { |value| value.odd? } == 2
count(1, 3, 6) { |value| value.even? } == 1
count(1, 3, 6) { |value| value > 6 } == 0
count(1, 3, 6) { |value| true } == 3
count() { |value| true } == 0
count(1, 3, 6) { |value| value - 6 } == 3
```

#### Solution:

```ruby
def count(*args)
  counter = 0
  args.each { |item| counter+= 1 if yield(item) }
  counter
end
```

- Note that we use *arguments in the method definition; this lets us treat the list of arguments as an Array of values, which means the rest of our count method does not need to change (other than the change in variable name).

### Exercise 5: drop_while

The `Enumerable#drop_while` method begins by iterating over the members of a collection, passing each element to the associated block until it finds an element for which the block returns false or nil. It then converts the remaining elements of the collection (including the element that resulted in a falsey return) to an Array, and returns the result.

Write a method called `drop_while` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return all the elements of the Array, except those elements at the beginning of the Array that produce a truthy value when passed to the block.

If the Array is empty, or if the block returns a truthy value for every element, `drop_while` should return an empty Array.

Your method may use `#each`, `#each_with_object`, `#each_with_index`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| true } == []
drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
drop_while([]) { |value| true } == []
```

#### Solution

```ruby
def drop_while(arr)
  idx = 0
  while idx < arr.size
    return arr[idx..-1] if !yield(arr[idx])
    idx += 1
  end
  arr = []
end
```

```ruby
def drop_while(arr)
  arr.each_with_index.with_object([]) do |(item, idx), _|
    return arr[idx..-1] if !yield(item)
  end
end
```

```ruby
# School's solution
def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end
```

### Exercise 6: each_with_index

The `Enumerable#each_with_index` method iterates over the members of a collection, passing each element and its index to the associated block. The value returned by the block is not used. `each_with_index` returns a reference to the original collection.

Write a method called `each_with_index` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should yield each element and an index number to the block. `each_with_index` should return a reference to the original Array.

Your method may use `#each`, `#each_with_object`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]

# should output:
# 0 -> 1
# 1 -> 3
# 2 -> 36
# true
```

#### Solution:

```ruby
def each_with_index(arr)
  idx = 0
  while idx < arr.size
    yield(arr[idx], idx)
    idx += 1
  end
  arr
end
```

### Exercise 7: each_with_object

The `Enumerable#each_with_object` method iterates over the members of a collection, passing each element and an arbitrary object (usually a collection) to the associated block. The value returned by the block is not used. The object that is passed to the block is defined as an argument to `each_with_object`; with each iteration, this object may be updated by the block. When iteration is complete, the final value of the object is returned.

Write a method called `each_with_object` that behaves similarly for Arrays. It should take an Array and an object of some sort as an argument, and a block. It should yield each element and the object to the block. `each_with_object` should return the final value of the object.

If the Array is empty, `each_with_object` should return the original object passed as its second argument.

Your method may use `#each`, `#each_with_index`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
result == {}
```

#### Solution:

```ruby
def each_with_object(arr, obj)
  arr.each do |item|
    yield(item, obj)
  end
  obj
end
```

### Exercise 8: max_by

The `Enumerable#max_by` method iterates over the members of a collection, passing each element to the associated block. It then returns the element for which the block returned the largest value.

Write a method called `max_by` that behaves similarly for Arrays. It should take an Array and a block, and return the element that contains the largest value.

If the Array is empty, `max_by` should return nil.

Your method may use `#each`, `#each_with_object`, `#each_with_index`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
max_by([1, 5, 3]) { |value| value + 2 } == 5
max_by([1, 5, 3]) { |value| 9 - value } == 1
max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
max_by([-7]) { |value| value * 3 } == -7
max_by([]) { |value| value + 5 } == nil
```

#### Solution:

```ruby
def max_by(arr)
  return nil if arr.empty?
  temp_arr = []
  arr.each { |item| temp_arr << yield(item) }
  arr[temp_arr.index(temp_arr.max)]
end
```

```ruby
def max_by(arr)
  return nil if arr.empty?
  largest = arr[0]
  arr.each { |item| largest = item if yield(item) > yield(largest) }
  largest
end
```

### Exercise 9: each_cons (Part 1)

The` Enumerable#each_cons` method iterates over the members of a collection taking each sequence of `n` consecutive elements at a time and passing them to the associated block for processing. It then returns a value of `nil`.

Write a method called `each_cons` that behaves similarly for Arrays, taking the elements 2 at a time. The method should take an Array as an argument, and a block. It should yield each consecutive pair of elements to the block, and return `nil`.

Your method may use `#each`, `#each_with_object`, `#each_with_index`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
result == nil
hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
hash == {}
result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
hash == {'a' => 'b'}
result == nil
```

#### Solution
```ruby
def each_cons(arr)
  start_idx = 0
  end_idx = 1
  
  while end_idx < arr.size
    yield(arr[start_idx..end_idx])  
    start_idx += 1
    end_idx += 1
  end
  
  nil
end
```

### Exercise 10: each_cons (Part 2)

In the previous exercise, we wrote a method that emulates `Enumerable#each_cons`, but limited our method to handling 2 elements at a time. `Enumerable#each_cons` can actually handle any number of elements at a time: 1, 2, 3, or more.

Update your `each_cons` method so it takes an argument that specifies how many elements should be processed at a time.

Your method may use `#each`, `#each_index`, `#each_with_object`, `#inject`, `loop`, `for`, `while`, or `until` to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

Examples:
```ruby
hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
hash == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
hash == {}
```

#### Solution
```ruby
def each_cons(arr, num_cons_elem)
  start_idx = 0
  
  while num_cons_elem <= arr[start_idx..-1].size
    yield(*arr[start_idx, num_cons_elem])  
    start_idx += 1
  end
  
  nil
end
```

- passing a variable number of elements to the block; we do this using the "splat" operator (*)
