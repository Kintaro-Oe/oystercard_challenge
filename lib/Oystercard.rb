class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 3

  attr_reader :balance, :in_use, :entry_station

  def initialize
    @balance = 0
    @in_use = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "Top up exceedes #{MAX_BALANCE} pound maximum balance" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    if @balance < MIN_BALANCE
     fail "Insufficient balance"
    else
      @in_use = true
      @entry_station = station
    end
  end

  def touch_out
    deduct(MIN_FARE)
    @in_use = false
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
