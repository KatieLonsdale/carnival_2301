class Visitor
  attr_reader :name, :height, :preferences
  attr_accessor :spending_money

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = format_spending_money(spending_money)
    @preferences = []
  end

  def format_spending_money(money)
    @spending_money = money.delete('$').to_i
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(height_requirement)
    @height >= height_requirement
  end
end
