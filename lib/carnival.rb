class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
    # @@revenue_from_carnivals = 0
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    riders_per_ride = {}
    @rides.map do |ride|
      riders_per_ride[ride] = ride.rider_log.values.sum
    end
    riders_per_ride.sort_by{|ride, riders| riders}.last.first
  end

  def most_profitable_ride
    @rides.sort_by{|ride| ride.total_revenue}.last
  end

  def total_revenue_from_rides
    @rides.map{|ride| ride.total_revenue}.sum
  end

  # def self.total_revenue_from_carnivals
  #   ObjectSpace.each_object(Carnival) do |carnival|
  #     @@revenue_from_carnivals += carnival.total_revenue_from_rides
  #   end
  #   @@revenue_from_carnivals
  # end
end
