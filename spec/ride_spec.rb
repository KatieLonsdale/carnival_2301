require 'spec_helper'

RSpec.describe Ride do 
  before(:each) do
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
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@ride1).to be_a Ride
      expect(@ride1.name).to eq('Carousel')
      expect(@ride1.min_height).to eq 24
      expect(@ride1.admission_fee).to eq 1
      expect(@ride1.excitement).to eq(:gentle)
    end
    it 'has a revenue of zero by default' do
      expect(@ride1.total_revenue).to eq 0
    end
    it 'has an empty rider log by default' do
      expect(@ride1.rider_log).to eq({})
    end
  end

  describe '#board_rider' do
    before(:each) do
      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)
    end
    it 'adds visitor ride to rider log' do
      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
    end
    it 'subtracts admission fee from rider spending money' do
      expect(@visitor1.spending_money).to eq 8
      expect(@visitor2.spending_money).to eq 4
    end
    it 'adds admission fee to ride total revenue' do
      expect(@ride1.total_revenue).to eq 3
    end
    it 'does not board rider unless they meet requirements' do
      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@visitor1.spending_money).to eq 8
      expect(@visitor2.spending_money).to eq 4
      expect(@visitor3.spending_money).to eq 13
      expect(@ride3.rider_log).to eq({@visitor3 =>1})
      expect(@ride3.total_revenue).to eq 2
    end
  end

  describe '#take_admission_from_rider' do
    it 'takes money from given rider and adds it to ride revenue' do
      @ride1.take_admission_from_rider(@visitor1)

      expect(@visitor1.spending_money).to eq 9
      expect(@ride1.total_revenue).to eq 1

      @ride1.take_admission_from_rider(@visitor2)

      expect(@visitor2.spending_money).to eq 4
      expect(@ride1.total_revenue).to eq 2
    end
  end

  describe '#meet_requirements?' do
    it 'determines if rider meets height requirement' do
      @visitor2.add_preference(:thrilling)
      @visitor1.add_preference(:thrilling)
      expect(@ride3.meet_requirements?(@visitor2)).to be false
      expect(@ride3.meet_requirements?(@visitor1)).to be true
    end
    it 'determines if rider meets money requirement' do
      @visitor4 = Visitor.new('Katie', 54, '$1')
      @visitor4.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      expect(@ride2.meet_requirements?(@visitor4)).to be false
      expect(@ride2.meet_requirements?(@visitor2)).to be true
    end
    it 'determines if rider meets preference requirement' do
      expect(@ride1.meet_requirements?(@visitor1)).to be false
      @visitor1.add_preference(:gentle)
      expect(@ride1.meet_requirements?(@visitor1)).to be true
    end
  end
end