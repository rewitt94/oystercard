class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 3
  attr_reader :entry_station, :exit_station

  def initialize(entry_station,exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  private
  def complete?
    @entry_station != nil && @exit_station != nil
  end

end
