require 'oystercard'

describe Oystercard do
  let(:station_in) { double(:station1) }
  let(:station_out) { double(:station2) }

  describe "#balance" do
    it { is_expected.to respond_to(:balance) }

    it "expects a default balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "increments balance by £10" do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it "raises an error if card balance exceeds maximum balance" do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect { subject.top_up(1) }.to raise_error("Top up exceedes #{Oystercard::MAX_BALANCE} pound maximum balance")
    end
  end

  # describe "#deduct" do   #this is private, we no longer need to test it. Read up on why, if unsure :)
  #   it "removes money from card" do
  #     expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
  #   end
  # end

  describe "#touch_in" do
    it "changes @in_use to true" do
      subject.top_up(Oystercard::MIN_BALANCE)
      expect { subject.touch_in(station_in) }.to change { subject.in_use }.from(false).to(true)
    end

    context "balance is less than MINIMUM" do
      it "raises an error" do
        expect { subject.touch_in(station_in) }.to raise_error("Insufficient balance")
      end
    end
  end

  describe "#touch_out" do
    let(:subject) {
      subject = described_class.new
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in(station_in)
      subject
    }

    it "changes @in_use to false" do
      expect { subject.touch_out(station_out) }.to change { subject.in_use }.from(true).to(false)
    end

    it "deducts minimum fare from card balance" do
      expect { subject.touch_out(station_out) }.to change { subject.balance }.by(-Oystercard::MIN_FARE)
    end

    it "removes entry station" do
      subject.touch_out(station_out)
      expect(subject.entry_station).to eq(nil)
    end

    it "returns nil for exit_station" do
      subject.touch_out(station_out)
      expect(subject.exit_station).to eq(nil)
    end

  end

  describe "#history" do
    it "returns empty list for a new card" do
      expect(subject.history).to eq([])
    end

    it "#touching in and out creates one journey" do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in(station_in)
      subject.touch_out(station_out)
      expect(subject.history).to include(station_in => station_out)
    end
  end
end
