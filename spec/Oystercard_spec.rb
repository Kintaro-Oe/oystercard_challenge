require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:balance) }

  it "expects a default balance" do
    expect(subject.balance).to eq 0
  end

  it "#top_up adds money to card" do
    expect { subject.top_up(10) }.to change { subject.balance }.from(0).to(10)
    expect { subject.top_up(10) }.to change { subject.balance }.from(10).to(20)
  end
end
