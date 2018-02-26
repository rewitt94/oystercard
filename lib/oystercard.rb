class Oystercard
attr_reader :balance
BALANCE_LIMIT = 90

  def initialize(initial_balance = 0)
    @balance = initial_balance
  end

  def top_up(amount)
    raise "max balance is #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT 
    @balance += amount
  end

end
