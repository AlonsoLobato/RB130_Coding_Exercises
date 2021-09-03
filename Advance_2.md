## RB130 - Ruby Foundations: More Topics --> Advance

### Exercise 2: Exploring Procs, Lambdas, and Blocks: Definition and Arity

For your answer to this exercise, write down your observations for each group of code. After writing out those observations, write one final analysis that explains the differences between procs, blocks, and lambdas.

#### Example 1: Proc

```ruby
my_proc = proc { |thing| puts "This is a #{thing}." }

puts my_proc
# #<Proc:0x000056035bb02b38 solution.rb:1>
puts my_proc.class
# Proc
my_proc.call
# This is a .
my_proc.call('cat')
# This is a cat.
```

- A Proc can be created (i.e. instantiated) with the shortcut `Kernel#proc` method instead of `Proc.new`
- Procs are instances of tha class Proc
- We execute Proc using the Proc#call instance method
- Procs are closures, meaning they remember and can use the entire context in which they were created (binding)
- But we can also pass arguments to the Proc as arguments in the #call method
- Procs have lenient arity, so we don't have to pass the exact number of arguments they expect
  - if we pass more arguments than expected, those will be ignored
  - if we pass less arguments than expected, the Proc parameters will be assigned to `nil`

#### Example 2: Lambda

```ruby
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }

puts my_lambda
# #<Proc:0x00007fc98713a788@/Users/alonso/Ruby_tests/tests.rb:1 (lambda)>
puts my_second_lambda
# #<Proc:0x00007fc98713a760@/Users/alonso/Ruby_tests/tests.rb:2 (lambda)>
puts my_lambda.class
# Proc
my_lambda.call('dog')
# This is a dog.
my_lambda.call
# wrong number of arguments (given 0, expected 1) (ArgumentError)
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }
```

- A lambda is a type of Proc object 
- It can be created using the shortcut `Kernel#lambda` method or the lambda syntax `->` 
- We cannot create a lambda using `Lambda.new`
- Lambdas have strict arity, so we have to pass the exact number of arguments that it expects, no more no less
- Otherwise, it'll rise an ArgumentError

#### Example 3: Block

```ruby
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
# This is a .
block_method_1('seal')
# no block given (yield) (LocalJumpError)
```

- Other type of closures are the blocks
- We can pass a block to a method as argument and pass the execution to the block from the method
- To do that we use the keyword `yield`
- We can pass arguments to the block via yield
- Blocks have lenient arity, so we don't have to pass the exact number of arguments they expect
  - if we pass more arguments than expected, those will be ignored
  - if we pass less arguments than expected, the Proc parameters will be assigned to `nil`
  - that's why the method does not print `This is a seal`, because the block paramenter is assigned to `nil` (no argument passed)
- If we define a method to yield to a block, we must pass a block to the method when we executed, otherwise a `no block given (yield) (LocalJumpError)` will be thrown

#### Example 4: More blocks


```ruby
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
# This is a turtle.

block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
# This is a turtle and a .

block_method_2('turtle') { puts "This is a #{animal}."}
# undefined local variable or method `animal'
```
- As mentioned before, we don't have to pass all arguments that blocks expect. This is called lenient arity.
- We see in the first call to the method that one argument is passed to a block that expects one argument, all ok
- The second call to the method we pass one argument to a block that expects two; so the second arg is assigned to `nil`
- The third call to the method we pass one argument to a block that expects no argument, and an error is raised
  - Blocks will throw an error if a variable is referenced that doesn't exist in the block's scope.


#### Comparison

- Lambdas are types of Proc's. Technically they are both Proc objects. An implicit block is a grouping of code, a type of closure, it is not an Object.
- Lambdas enforce the number of arguments passed to them (strict arity). Implicit blocks and Procs do not enforce the number of arguments passed in (lenient arity).  
