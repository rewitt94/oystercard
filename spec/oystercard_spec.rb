require 'oystercard'

describe Oystercard do

  context 'Oystercard starts with balance 40 - unless stated otherwise' do
    let(:entry_station) { double('entry_station') }
    let(:exit_station) { double('exit_station')}
    let(:journey_log) { double :journey_log, add_journey: nil }
    # allow(:journey_log).to_receive(:add_journey).with('an argument')
    subject(:oystercard) { Oystercard.new(journey_log, 40) }

    describe 'creation of Oystercards' do

      context '#new with first parameter set' do
        subject(:oystercard) { Oystercard.new(:test, 40) }

        it 'first parameter is injected to journeys' do
          expect(subject.journeys).to eq(:test)
        end
      end



      context '#new without second parameter' do
        subject(:oystercard) { Oystercard.new(:journey_log) }

        it 'default balance is 0' do
          expect(subject.balance).to eq(0)
        end

      end

      context '#new with second parameter' do
        subject(:oystercard) { Oystercard.new(:journey_log, 20) }

        it 'sets parameter to balance' do
          expect(subject.balance).to eq(20)
        end

      end



    end

    describe 'transactions' do

      describe '#top_up' do
        it 'adds to balance using positive parameter' do
          expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
        end
      end

      describe '#touch_out' do
        it 'reduces your balance by minimum fare' do
          expect{ subject.touch_out(:exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
        end
      end

    end

    describe 'in_journey? predicate' do

      it 'should default to false' do
        expect(subject.in_journey?).to be_falsey
      end

      describe '#touch_in' do
        it 'changes #in_journey? from false to true' do
          expect{ subject.touch_in(:entry_station) }.to change{ subject.in_journey? }.from(false).to(true)
        end

        it 'no change if already in journey' do
          subject.touch_in(:entry_station)
          expect{ subject.touch_in(:entry_station) }.not_to change{ subject.in_journey? }
        end

      end

      describe '#touch_out' do
        it 'changes #in_journey? from true to false' do
          subject.touch_in(:entry_station)
          expect{ subject.touch_out(:exit_station) }.to change{ subject.in_journey? }.from(true).to(false)
        end

      end

    end

    describe 'balance errors' do

      describe '#top_up' do

        it 'cannot exceed balance limit' do
          expect{ subject.top_up(91) }.to raise_error "max balance is #{Oystercard::BALANCE_LIMIT}"
        end

        # it 'cannot make a transaction with insufficient funds' do
        #   expect { subject.transaction(-41) }.to raise_error "insufficient funds: current balance is #{subject.balance}"
        # end
      end

      describe '#touch_in' do
        subject(:oystercard) { Oystercard.new(Oystercard::TOUCH_IN_MINIMUM - 0.01) }

        it 'cannot touch in with balance less than one' do
          expect{ subject.touch_in(:entry_station) }.to raise_error("touch in mimimum is #{Oystercard::TOUCH_IN_MINIMUM}")
        end

      end

    end

    describe 'entry station attribute' do

      describe '#touch_in' do
        it 'store entry station upon touch in' do
          expect{ subject.touch_in(:entry_station) }.to change{ subject.entry_station }.from(nil).to(:entry_station)
        end
      end

      describe '#touch_out' do
        it 'deletes entry station upon touch out' do
          subject.touch_in(:entry_station)
          expect{ subject.touch_out(:exit_station) }.to change{ subject.entry_station }.from(:entry_station).to(nil)
        end
      end

    end

    describe 'journeys attribute' do

      describe '#touch_out' do
        it 'adds a journey to journeys' do
          subject.touch_in(:entry_station)
          expect{ subject.touch_out(:exit_station) }.to change{ subject.journeys.empty? }.from(true).to(false)
        end
      end

    end

  end

end
