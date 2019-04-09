require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:balance) }

  it "expects a default balance" do
    expect(subject.balance).to eq 0
  end

  context '#top_up' do
    it "#top_up adds money to card" do
      expect { subject.top_up(10) }.to change { subject.balance }.from(0).to(10)
      expect { subject.top_up(10) }.to change { subject.balance }.from(10).to(20)
    end

    it 'raises an error if card balance exceeds limit' do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1) }.to raise_error("Top up exceedes #{Oystercard::LIMIT} pound maximum balance")
    end
  end

  it "#deduct removes money from card" do
    expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
  end

  it "#touch_in changes @in_use to true" do
    expect { subject.touch_in }.to change { subject.in_use }.from(false).to(true)
  end

  it "#touch_out changes @in_use to false" do
    subject.touch_in
    expect { subject.touch_out }.to change { subject.in_use }.from(true).to(false)
  end

  context "#in_journey?" do
    it "checks whether card is @in_use" do
      expect(subject.in_journey?).to eq false
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
  end
end
