class Oystercard

TOP_UP_LIMIT = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

  attr_reader :balance, :entry_station, :list_of_journeys

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(value)
    fail "Error, card has limit of #{TOP_UP_LIMIT}" if value + balance > TOP_UP_LIMIT
    @balance += value
  end

  def touch_in(entry_station)
    raise "No money" if balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @list_of_journeys = { entry: @entry_station, exit: exit_station }
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
