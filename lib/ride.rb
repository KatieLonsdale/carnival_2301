class Ride
 attr_reader :name,
            :min_height, 
            :admission_fee, 
            :excitement, 
            :total_revenue,
            :rider_log

 def initialize(ride_info)
  @name = ride_info[:name]
  @min_height = ride_info[:min_height]
  @admission_fee = ride_info[:admission_fee]
  @excitement = ride_info[:excitement]
  @total_revenue = 0
  @rider_log = {}
 end

  def board_rider(rider)
  # add helper methods for extra logic
    unless meet_requirements?(rider)
      rider.spending_money = rider.spending_money - @admission_fee
      @total_revenue += @admission_fee
      # terenary
      if @rider_log.has_key?(rider)
        @rider_log[rider] += 1
      else
        @rider_log[rider] = 1
      end
    end
  end

  def meet_requirements?(rider)
    height = rider.height >= @min_height
    money = rider.spending_money >= @admission_fee
    preferences = rider.preferences.include?(@excitement)
    (height && money) && preferences
  end
end
