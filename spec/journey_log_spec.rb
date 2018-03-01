require 'journey_log.rb'
describe JourneyLog do

  subject(:journey_log) { JourneyLog.new }

  describe 'creation of journey log' do
    it 'contains an array' do
      expect(subject.log).to be_an_instance_of(Array)
    end

    it 'is an empty array' do
      expect(subject.log).to be_empty
    end
  end

  describe '#add_journey' do
    it 'adds a journey to the array' do
      expect(subject.add_journey(:journey)).to include(:journey)
    end
  end
  
end
