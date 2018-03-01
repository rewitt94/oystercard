require_relative 'journey_log.rb'

class Oystercard
  attr_reader :balance, :entry_station
  attr_accessor :journeys
  BALANCE_LIMIT = 90
  TOUCH_IN_MINIMUM = 1
  MINIMUM_FARE = 2

  def initialize(journeylog = JourneyLog.new, initial_balance = 0)
    @balance = initial_balance
    @entry_station = nil
    @journeys = journeylog

  end

  def top_up(amount)
    raise "max balance is #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "touch in mimimum is #{Oystercard::TOUCH_IN_MINIMUM}" if @balance < TOUCH_IN_MINIMUM
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @journeys.add_journey({entry: @entry_station, exit: exit_station})
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
