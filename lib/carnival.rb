class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
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
end
