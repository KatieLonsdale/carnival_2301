require 'spec_helper'

RSpec.describe Carnival do 
  before(:each) do
    @carnival = Carnival.new('3 hours')
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@carnival).to be_a Carnival
      expect(@carnival.duration).to eq('3 hours')
    end
  end
end