class Journey
  attr_reader :list_of_journeys

  def initialize
    @list_of_journeys = []
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @list_of_journeys << { entry: @entry_station, exit: exit_station }
    @exit_station = exit_station
  end

  def complete?
    @list_of_journeys[-1] == { entry: @entry_station, exit: @exit_station }
  end

end