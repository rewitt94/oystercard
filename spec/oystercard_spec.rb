require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  describe 'creation of Oystercards' do

    context 'created without parameter' do

      it 'default balance is 0' do
        expect(subject.balance).to eq(0)
      end

    end

    context 'created with parameter' do
      subject(:oystercard) { Oystercard.new(20) }

      it 'sets parameter to balance' do
        expect(subject.balance).to eq(20)
      end

    end

  end

  describe '#top_up' do

    it 'adds to balance' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

  end

end
