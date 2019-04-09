class Oystercard
  LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top up exceedes #{LIMIT} pound maximum balance" if @balance + amount > LIMIT
    @balance += amount
  end
end
