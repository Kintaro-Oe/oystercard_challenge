require 'oystercard'

describe Oystercard do
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

  describe "#deduct" do
    it "removes money from card" do
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
  end

  describe "#touch_in" do
    it "changes @in_use to true" do
      subject.top_up(Oystercard::MIN_BALANCE)
      expect { subject.touch_in }.to change { subject.in_use }.from(false).to(true)
    end

    context "balance is less than MINIMUM" do
      it "raises an error" do
        expect { subject.touch_in }.to raise_error("Insufficient balance")
      end
    end
  end

  describe "#touch_out" do
    it "changes @in_use to false" do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.in_use }.from(true).to(false)
    end
  end

  describe "#in_journey?" do
    it "checks whether card is @in_use" do
      subject.top_up(Oystercard::MIN_BALANCE)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "checks a new card is not @in_use" do
      expect(subject.in_journey?).to eq false
    end
  end

end
