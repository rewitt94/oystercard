require 'journey'

describe Journey do
  describe 'creation of journeys' do

    context 'two stations give as parameters' do
      subject(:journey) { described_class.new(:entry_station,:exit_station)}
      it 'fare is set to minimum' do
        expect(subject.fare).to eq(Journey::MINIMUM_FARE)
      end

      it 'attribute entry returns entry station' do
        expect(subject.entry_station).to eq(:entry_station)
      end

      it 'attribute exit returns exit station' do
        expect(subject.exit_station).to eq(:exit_station)
      end
    end

    context 'entry station is nil' do
      subject(:journey) { described_class.new(nil,:exit_station)}
      it 'fare is set to penalty fare' do
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
    end

    context 'exit station is nil' do
      subject(:journey) { described_class.new(:entry_station,nil)}
      it 'fare is set to penalty fare' do
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
    end
  end
end
