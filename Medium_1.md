## RB130 - Ruby Foundations: More Topics --> Medium 1

### Exercise 1: Listening device

Below we have a listening device. It lets us record something that is said and store it for later use. In general, this is how the device should be used:

Listen for something, and if anything is said, record it for later use. If nothing is said, then do not record anything.

```ruby
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end
end
```

Anything that is said is retrieved by this listening device via a block. If nothing is said, then no block will be passed in. The listening device can also output the most recent recording using a `Device#play` method.

```ruby
listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
```

Finish the above program so that the specifications listed above are met.

#### Solution
```ruby
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end
  
  def listen
    record(yield) if block_given?
  end
  
  def play
    puts @recordings.last
  end
end
```

### Exercise 2: Text Analyzer - Sandwich Code

Fill out the rest of the Ruby code below so, for any given text file, it prints output the number of paragraphs, the number of lines and the number of words in the text. 

** This question requires that you read a simple text file. Try searching the Web for information on how to do this, and also take a look at the File class in the Ruby documentation.

Read the text file in the `#process` method and pass the text to the block provided in each call. Everything you need to work on is either part of the `#process` method or part of the blocks. You need no other additions or changes.

```ruby
class TextAnalyzer
  def process
    # your implementation
  end
end

analyzer = TextAnalyzer.new
analyzer.process { # your implementation }
analyzer.process { # your implementation }
analyzer.process { # your implementation }
```

#### Solution:
```ruby
class TextAnalyzer
  def process
    text_file = File.open('/Users/alonso/Ruby_tests/sample_text.txt')
    yield(text_file.read)
    text_file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "There are #{text.split("\n\n").count} paragraphs in the text"   }
analyzer.process { |text| puts "There are #{text.split("\n").count} lines in the text"  }
analyzer.process { |text| puts "There are #{text.split.count} words in the text" }
```

- This is an example of what we call "sandwich code"; it performs some pre- and post-processing for some arbitrary action. Here, the pre-processing opens a file, and the post-processing closes it. Together, they sandwich the action that loads the file's contents and passes it to a block.

### Exercise 3: Passing Parameters Part 1

Modify the method below so that the display/output of `items` is moved to a block, and its implementation is left up to the user of the `gather` method.

```ruby
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  puts "#{items.join(', ')}"
  puts "Nice selection of food we have gathered!"
end
```

#### Solution
```ruby
def gather(items)
  puts "Let's start gathering food."
  yield(items) if block_given?
  puts "Nice selection of food we have gathered!"
end

items = ['apples', 'corn', 'cabbage', 'wheat']

gather(items) { |item| puts item }
# Let's start gathering food.
# apples
# corn
# cabbage
# wheat
# Nice selection of food we have gathered!
```

### Exercise 4: Passing Parameters Part 2

Write a method that takes an array as an argument. The method should yield the contents of the array to a block, which should assign your block variables in such a way that it ignores the first two elements, and groups all remaining elements in a separate block variable.

#### Solution
```ruby
def array_items_to_variables(array)
  yield(array)
end

array_items_to_variables(%w(raven finch hawk eagle)) { |_, _, *valid_var| puts valid_var }
# hawk
# eagle
```

#### School's solution
```ruby
birds = ['crow', 'finch', 'hawk', 'eagle']

def types(birds)
  yield birds
end

types(birds) do |_, _, *raptors|
  puts "Raptors: #{raptors.join(', ')}."
end
# Raptors: hawk, eagle.
```

- When we yield birds to the block, Ruby assigns the individual elements of birds to the different block variables. It assigns the first two birds, "crow" and "finch," to _; the underscore tells Ruby that we aren't interested in those values. The splat operator on the name block variable tells Ruby to treat it as an Array and assign all remaining arguments to it. Here, we group the last two elements from birds into the array, raptors.


### Exercise 5: Passing Parameters Part 3

Given this code:

```ruby
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end
```

Fill out the following method calls for gather so that they produce the corresponding output shown in numbers 1-4 listed below:

1)
```ruby
gather(items) do | , |
  puts
  puts
end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!
```

#### Solution
```ruby
gather(items) do |*greens, cereals|
  puts greens.join(', ')
  puts cereals
end
```

2)
```ruby
gather(items) do | , , |
  puts
  puts
  puts
end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!
```

#### Solution
```ruby
gather(items) do | fruit, *vegetable, cereal |
  puts fruit
  puts vegetable.join(', ')
  puts cereal
end
```

3)
```ruby
gather(items) do | , |
  puts
  puts
end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!
```

#### Solution
```ruby
gather(items) do | fruit, *non_fruit |
  puts fruit
  puts non_fruit.join(', ')
end
```

4)
```ruby
gather(items) do | , , , |
  puts
end

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!
```

#### Solution
```ruby
gather(items) do | item1, item2 , item3 , item4 |
  puts "#{item1}, #{item2}, #{item3} and #{item4}"
end
```

### Exercise 6: Method to Proc


### Exercise 7: Bubble Sort with Blocks

