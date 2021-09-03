=begin
#(1) Write a test that verifies that Transaction#prompt_for_payment sets the amount_paid correctly.
=end

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class TransactionTest < MiniTest::Test

  def setup
    @cash_register = CashRegister.new(100)
    @sample_transaction = Transaction.new(20)
  end

  def test_prompt_for_payment
    input = StringIO.new("20\n")
    output = StringIO.new
    @sample_transaction.prompt_for_payment(input: input, output: output)
    assert_equal 20, @sample_transaction.amount_paid        
  end
end
