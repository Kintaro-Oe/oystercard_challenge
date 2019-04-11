require 'journey'

describe Journey do
let(:entry_station) { double(:entry_station) }
let(:exit_station) { double(:exit_station) }

  context "stores station info" do
  subject { described_class.new(entry_station,exit_station) }
    it "stores the entry station" do
      expect(subject.entry_station).to eq(entry_station)
    end

    it "stores the exit station" do
      expect(subject.exit_station).to eq(exit_station)
    end
  end

  context "is complete" do
  subject { described_class.new(entry_station,exit_station) }
    it "returns true if journey is complete" do
      expect(subject.complete?).to eq(true)
    end
  end

  context "is incomplete"
    it "returns false if entry_station is nil" do
      subject = described_class.new(nil,exit_station)
      expect(subject.complete?).to eq(false)
    end
    it "returns false if exit_station is nil" do
      subject = described_class.new(entry_station,nil)
      expect(subject.complete?).to eq(false)
    end

    describe "#fare" do
      it "returns minimum fare by default" do
        subject = described_class.new(entry_station,exit_station)
        expect(subject.fare).to eq(Journey::MIN_FARE)
      end

      it "returns penalty fare when no entry station" do
        subject = described_class.new(nil,exit_station)
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end

      it "returns penalty fare when no exit station" do
        subject = described_class.new(entry_station,nil)
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
    end
end
