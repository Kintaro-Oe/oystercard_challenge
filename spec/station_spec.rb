require 'station'

describe Station do
  # context 'set default values' do
  #   let(subject){Station.new}
  #   it 'has a default zone of nil' do
  #     expect(subject.zone).to eq nil
  #   end
  #
  #   it 'has a default name of nil' do
  #     expect(subject.name).to eq nil
  #   end
  # end

  context 'initialize the station' do
    subject { described_class.new('aldgate', 1) }

    it 'store the zone info' do
      expect(subject.zone).to eq 1
    end

    it 'store the name ' do
      expect(subject.name).to eq 'aldgate'
    end
  end
end
