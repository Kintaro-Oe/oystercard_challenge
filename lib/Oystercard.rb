class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Top up exceedes #{MAX_BALANCE} pound maximum balance" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    if @balance < MIN_BALANCE
     fail "Insufficient balance"
   else
    @in_use = true
    end
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end
end
