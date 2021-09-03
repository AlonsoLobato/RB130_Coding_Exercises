=begin
#(1) Write a test for the CashRegister#accept_money method.
#(2) Write a test for the method, CashRegister#change
#(3) Write a test for method CashRegister#give_receipt that ensures it displays a valid receipt.
=end

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < MiniTest::Test

  def setup
    @cash_register = CashRegister.new(100)
    @sample_transaction = Transaction.new(10)
  end

  def test_accept_money                                  #(1)
    previous_amount = @cash_register.total_money
    @sample_transaction.amount_paid = 10
    @cash_register.accept_money(@sample_transaction)
    current_amount = @cash_register.total_money
    assert_equal(previous_amount + 10, current_amount)
  end

  def test_change                                         #(2)
    @sample_transaction.amount_paid = 20
    change_due = @cash_register.change(@sample_transaction)
    assert_equal 10, change_due
  end

  def test_change_b                                       #(2)
    @sample_transaction.amount_paid = 20
    paid = @sample_transaction.amount_paid
    real_cost = @sample_transaction.item_cost
    change_due = @cash_register.change(@sample_transaction)
    assert_equal(paid - real_cost, change_due)
  end

  def test_give_receip                                     #(3)
    assert_output("You've paid $10.\n") { @cash_register.give_receipt(@sample_transaction) }
  end


end


