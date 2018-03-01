class JourneyLog
  attr_reader :log

  def initialize
    @log = []
  end

  def add_journey(journey)
    @log << journey
  end
end
