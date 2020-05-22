require 'journey'

class Oystercard

TOP_UP_LIMIT = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = Journey.new
  end

  def top_up(value)
    fail "Error, card has limit of #{TOP_UP_LIMIT}" if limit_exceeded?(value)

    @balance += value
  end

  def touch_in(entry_station)
    raise "No money" if balance < MINIMUM_FARE

    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey.end_journey(exit_station)
  end

  def in_journey?
    !!@entry_station
  end

  def limit_exceeded?(value)
    value + @balance > TOP_UP_LIMIT
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
