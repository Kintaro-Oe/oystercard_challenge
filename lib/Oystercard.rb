class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 3

  attr_reader :balance, :in_use, :entry_station, :exit_station, :history

  def initialize
    @balance = 0
    @in_use = false
    # @entry_station = nil
    # @exit_station = nil
    @history = []
  end

  def top_up(amount)
    raise "Top up exceedes #{MAX_BALANCE} pound maximum balance" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    @journey = Journey.new(entry_station)
    if @balance < MIN_BALANCE
     fail "Insufficient balance"
    else
      @in_use = true
    #@entry_station = entry_station
    end
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @in_use = false
    @journey.exit_station = exit_station
    #@exit_station = exit_station
    @history << {@journey.entry_station => @journey.exit_station}
    #@entry_station = nil
    #@exit_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
