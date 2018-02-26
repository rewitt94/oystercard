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

  describe '#transaction' do

    it 'adds to balance' do
      subject.transaction(30)
      expect(subject.balance).to eq(30)
    end

    it 'subtract from balance #assuming adds to balance works' do
      subject.transaction(30)
      subject.transaction(-10)
      expect(subject.balance).to eq(20)
    end

    it 'throws a wobbly if you try to exceed balance limit' do
      expect { subject.transaction(91) }.to raise_error "max balance is #{Oystercard::BALANCE_LIMIT}"
    end

    it 'cannot make a transaction with insufficient funds' do
      expect { subject.transaction(-1) }.to raise_error "insufficient funds: current balance is #{subject.balance}"
    end

  end

end
