class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 3
  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station,exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = self.calcuate_fare(entry_station,exit_station)
  end

  def calcuate_fare(entry_station,exit_station)
    if entry_station == nil || exit_station == nil
      return PENALTY_FARE
    else
      return MINIMUM_FARE
    end
  end

end
