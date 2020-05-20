require 'oystercard'

describe Oystercard do

  let (:card1) {Oystercard.new}
  let (:card_with_money) {Oystercard.new(20)} 

  it "has a balance" do
  expect(subject.balance).to eq(0)
  end

  it "receives a top up when initialized" do
    expect(card_with_money.instance_variable_get(:@balance)).to eq(20)
  end

  it "tops up balance with" do
  expect(subject.top_up(10)).to eq 10
  end

  it "errors with over limit" do
    limit = Oystercard::TOP_UP_LIMIT
    expect { subject.top_up(limit + 1) } .to raise_error "Error, card has limit of #{limit}"
  end

  # describe '#deduct' do
  #   [3,5,7].each do |num|
  #     it "should reduced the balane by the given argument" do
  #       subject.deduct(num)
  #       expect(subject.balance).to eq(-num)
  #     end
  #   end
  # end

  describe '#in_journey?' do
    it "should return false" do
      expect(subject).not_to be_in_journey
    end
  end

  context "no top up" do
    describe "#touch_in" do
      it "should raise_error 'No money' if balance is below min_fare" do
        expect { subject.touch_in }.to raise_error( "No money" )
      end
    end
  end

  context "top_up 5" do
    before do
      subject.top_up(5)
      subject.touch_in
    end

    describe '#touch_in' do
      it "should change #in_journey to true" do
        expect(subject).to be_in_journey
      end
      xit "stores current entry station" do
        expect(subject.current_station).to eq(current_station)
      end
    end

    describe '#touch_out' do
      it "should change #in_journey to false" do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
      it "should deduct the minimum fare from the card" do
        min_fare = Oystercard::MINIMUM_FARE
        expect { subject.touch_out }.to change{ subject.balance }.by(-min_fare)
      end
    end
  end
end
