class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 3

  attr_reader :balance, :in_use, :entry_station, :exit_station, :history

  def initialize
    @balance = 0
    @in_use = false
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def top_up(amount)
    raise "Top up exceedes #{MAX_BALANCE} pound maximum balance" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station_in)
    if @balance < MIN_BALANCE
     fail "Insufficient balance"
    else
      @in_use = true
      @entry_station = station_in
    end
  end

  def touch_out(station_out)
    deduct(MIN_FARE)
    @in_use = false
    @exit_station = station_out
    @history << {@entry_station => @exit_station}
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
