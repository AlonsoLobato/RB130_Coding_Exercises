# RB130 - Ruby Foundations: More Topics --> Medium Testing --> Exercises 8, 9 and 10
# It uses a separate text_sample.txt file


# Write test cases for the 'swap' and 'word_count' methods
# Make sure you use 'setup' and 'teardow' Minitest methods to open and close the text file

require 'minitest/autorun'
require_relative 'text'

class TextTest < MiniTest::Test

  def setup
    @file = File.open('/Users/alonso/RB130_More_Topics_Problems/Medium_Testing/text_sample.txt')
    text_from_file = @file.read
    @text = Text.new(text_from_file)
  end

  def test_swap
    text_mutated = <<~TEXT
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal text_mutated, @text.swap('a', 'e')
  end

  def test_word_count
    assert_equal 72, @text.word_count
  end

  def teardown
    @file.close
    puts "File has been closed: #{@file.closed?}"  # This last line is to ensure that the closing operation has been performed successfully
  end
end
