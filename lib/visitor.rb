class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money.delete('$').to_i
    # add helper method
    @preferences = []
  end
end
