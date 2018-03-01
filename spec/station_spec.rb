require 'station'

describe Station do

  context 'Station is Algate East, Zone 2' do
    subject(:station) { described_class.new('Algate East', 2) }

    it 'attribute name returns "Algate East"' do
      expect(subject.name).to eq('Algate East')
    end

    it 'attribute zone returns 2' do
      expect(subject.zone).to eq(2)
    end

  end

end
