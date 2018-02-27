require 'oystercard'

describe Oystercard do
  context 'Oystercard starts with balance 40 - unless stated otherwise' do
    subject(:oystercard) { Oystercard.new(40) }

    describe 'creation of Oystercards' do

      context 'created without parameter' do
        subject(:oystercard) { Oystercard.new }

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

      it 'adds to balance using positive parameter' do
        subject.transaction(10)
        expect(subject.balance).to eq(50)
      end

      it 'subtract from balance using negative parameter' do
        subject.transaction(-20)
        expect(subject.balance).to eq(20)
      end

      it 'cannot exceed balance limit' do
        expect { subject.transaction(91) }.to raise_error "max balance is #{Oystercard::BALANCE_LIMIT}"
      end

      it 'cannot make a transaction with insufficient funds' do
        expect { subject.transaction(-41) }.to raise_error "insufficient funds: current balance is #{subject.balance}"
      end

    end

    describe '#in_journey?' do

      it 'should default to false' do
        expect(subject.in_journey?).to be_falsey
      end

      describe '#touch_in' do
        it 'changes #in_journey? from false to true' do
          expect{ subject.touch_in }.to change{ subject.in_journey? }.from(false).to(true)
        end

        it 'no change if already in journey' do
          subject.touch_in
          expect{ subject.touch_in }.not_to change{ subject.in_journey? }
        end

      end

      describe '#touch_out' do
        it 'changes #in_journey? from true to false' do
          subject.touch_in
          expect{ subject.touch_out }.to change{ subject.in_journey? }.from(true).to(false)
        end

      end

    end

  end

end
