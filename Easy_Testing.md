## RB130 - Ruby Foundations: More Topics --> Easy Testing

### Exercise 1: Boolean Assertions

Write a minitest assertion that will fail if the `value.odd?` is not true.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_odd_return_true
    value = 1
    assert_equal(true, value.odd?)
  end
  
  def test_odd_return_false
    value = 2
    assert_equal(false, value.odd?)
  end
end
```

### Exercise 2: Equality Assertions

Write a minitest assertion that will fail if `value.downcase` does not return `'xyz'`.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_downcase_1
    value = 'XYZ'
    assert_equal('xyz', value.downcase)
  end
  
  def test_downcase_2
    value = 'xyz'
    assert_equal('xyz', value.downcase)
  end
  
  def test_dowcase_fails
    value = 'XYZ'
    refute_equal('XYZ', value.downcase)
  end
end
```

### Exercise 3: Nil Assertions

Write a minitest assertion that will fail if value is not `nil`.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test

  def test_nil_value
    value = nil
    assert_nil(value)
  end
  
  def test_no_nil_value
    value = 1
    refute_nil(value)
  end
end
```

### Exercise 4: Empty Object Assertions

Write a minitest assertion that will fail if the Array `list` is not empty.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test

  def test_array_is_empty
    arr = []
    assert_equal(true, arr.empty?)
  end
end
```

### Exercise 5: Included Object Assertions

Write a minitest assertion that will fail if the `'xyz'` is not in the Array `list`.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_arr_include_value
    arr = ['xyz']
    assert_includes(arr, 'xyz')
  end
end
```

### Exercise 6: Exception Assertions

Write a minitest assertion that will fail unless `employee.hire` raises a `NoExperienceError` exception.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_hire
    assert_raises('NoExperienceError') { employee.hire }
  end
end
```

### Exercise 7: Type Assertions

Write a minitest assertion that will fail if `value` is not an instance of the `Numeric` class exactly. `value` may not be an instance of one of `Numeric`'s superclasses.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_value_instance_of_numeric
    value = Numeric.new
    assert_instance_of(Numeric, value)
  end
end
```

### Exercise 8: Kind Assertions

Write a minitest assertion that will fail if the class of `value` is not `Numeric` or one of `Numeric`'s subclasses (e.g., `Integer`, `Float`, etc).

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test
  def test_value_not_kind_of_numeric
    value = Numeric.new
    assert_kind_of(Numeric, value)
  end
end
```

### Exercise 9: Same Object Assertions

Write a test that will fail if `list` and the return value of `list.process` are different objects.

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test

  def test_same_objects
    value = String.new
    value2 = value
    assert_same(value, value2)
  end
end
```

### Exercise 10: Refutations

Write a test that will fail if `'xyz'` is one of the elements in the Array `list`

#### Solution

```ruby
require 'minitest/autorun'

class MyTest < MiniTest::Test

  def test_val_is_in_arr
    arr = []
    refute_includes(arr, 'xyz')
  end
end
```


