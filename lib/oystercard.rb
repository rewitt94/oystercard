class Oystercard
attr_reader :balance
BALANCE_LIMIT = 90

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @touch = false
  end

  def transaction(amount)
    raise "max balance is #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    raise "insufficient funds: current balance is #{@balance}" if (@balance + amount) < 0
    @balance += amount
  end

  def touch_in
    @touch = true
  end

  def touch_out
    @touch = false
  end

  def in_journey?
    @touch
  end

end
