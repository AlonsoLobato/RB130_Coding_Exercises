def factorial_generator(num)
  return 1 if num == 0
  (1..num).reduce(&:*)
end

fact_enum = Enumerator.new do |fact|
  counter = 0
  loop do
    fact.yield(factorial_generator(counter))
    counter += 1
  end
end

# External iterations
6.times { |numb| puts "Factorial of #{numb} is #{fact_enum.next}"}
puts '---'

fact_enum.rewind # rewind tells fact_enum to start the iteration from 0, instead of where last use of fact_enum (on previous times method) stopped

6.times { |numb| puts "Factorial of #{numb} is #{fact_enum.next}"}
puts '---'

# Internal iterations
fact_enum.each_with_index do |num, idx|
  puts "Factorial of #{idx} is #{num}"
  break if idx >= 5
end
