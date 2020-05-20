class Oystercard

TOP_UP_LIMIT = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_use = false
  end

  def top_up(value)
    fail "Error, card has limit of #{TOP_UP_LIMIT}" if value + balance > TOP_UP_LIMIT
    @balance += value
  end

  def touch_in(entry_station)
    raise "No money" if balance < MINIMUM_FARE
    @in_use = true
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
    @entry_station = nil
  end

  def in_journey?
    !!@in_use
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
