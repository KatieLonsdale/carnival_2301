require 'spec_helper'

RSpec.describe Carnival do 
  before(:each) do
    @carnival = Carnival.new('3 hours')
    @ride1 = Ride.new({
      name: 'Carousel', 
      min_height: 24, 
      admission_fee: 1, 
      excitement: :gentle 
    })
    @ride2 = Ride.new({
      name: 'Ferris Wheel',
      min_height: 36,
      admission_fee: 5,
      excitement: :gentle 
    })
    @ride3 = Ride.new({
      name: 'Roller Coaster',
      min_height: 54,
      admission_fee: 2,
      excitement: :thrilling 
    })
    @visitor1 = Visitor.new('Bruce', 54, '$50')
    @visitor2 = Visitor.new('Tucker', 60, '$50')
    @visitor3 = Visitor.new('Penny', 64, '$50')
    # changed attributes so height and money would not prevent 
    # from riding to make testing easier
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor3.add_preference(:gentle)
    @visitor1.add_preference(:thrilling)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@carnival).to be_a Carnival
      expect(@carnival.duration).to eq('3 hours')
    end
    it 'has an empty array of rides by default' do
      expect(@carnival.rides).to eq([])
    end
  end

  describe '#add_ride' do
    it 'adds a ride to the rides attribute' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.rides).to eq([@ride1, @ride2, @ride3])
    end
  end

  describe '#most_popular_ride' do
    it 'returns ride with most riders' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride3.board_rider(@visitor2)

      expect(@carnival.most_popular_ride).to eq(@ride1)
    end
  end

  describe '#most_profitable_ride' do
    it 'returns the ride with highest total revenue' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride3.board_rider(@visitor2)

      expect(@carnival.most_profitable_ride).to eq(@ride2)
    end
  end

  describe '#total_revenue_from_rides' do
    it 'returns total revenue earned from its rides' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor3)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride3.board_rider(@visitor2)

      expect(@carnival.total_revenue_from_rides).to eq 15
    end
  end

  # describe '#carnival_summary' do
  #   it 'returns summary of visitor and revenue related info' do

  #   end
  # end

  # describe '#total_revenue_from_carnivals' do
  #   it 'returns total revenue earned from all carnivals' do
  #     @carnival1 = Carnival.new('3 days')
  #     @carnival2 = Carnival.new('2 days')
  #     @carnival3 = Carnival.new('7 days')
  #     @carnival1.add_ride(@ride1)
  #     @carnival1.add_ride(@ride2)
  #     @carnival1.add_ride(@ride3)
  #     @ride1.board_rider(@visitor1)
  #     @ride1.board_rider(@visitor2)
  #     @ride1.board_rider(@visitor3)
  #     @ride2.board_rider(@visitor1)
  #     @ride2.board_rider(@visitor2)
  #     @ride3.board_rider(@visitor2)
  #     # 15

  #     @carnival2.add_ride(@ride1)
  #     @ride1.board_rider(@visitor1)
  #     @ride1.board_rider(@visitor2)
  #     @ride1.board_rider(@visitor3)
  #     # 3

  #     @carnival3.add_ride(@ride2)
  #     @ride2.board_rider(@visitor1)
  #     @ride2.board_rider(@visitor2)
  #     # 10

  #     expect(Carnival.total_revenue_from_carnivals).to eq 28
  #   end
  # end
end