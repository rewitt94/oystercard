require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  describe 'creation of Oystercards' do
    it 'default balance is 0' do
      expect(subject.balance).to eq(0)
    end 
  end 


end
