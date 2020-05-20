require 'oystercard'

describe Oystercard do

  let (:card1) {Oystercard.new}
  let (:card_with_money) {Oystercard.new(20)}
  let (:station) { double(:station) }
  let (:exit_station) { double(:exit_station) }

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
        expect { subject.touch_in(station) }.to raise_error( "No money" )
      end
    end
  end

  context "top_up 5" do
    before do
      subject.top_up(5)
      subject.touch_in(station)
    end

    describe '#touch_in' do
      it "should change #in_journey to true" do
        expect(subject).to be_in_journey
      end
    end

    describe '#touch_out' do
      it "should change #in_journey to false" do
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end
      it "should deduct the minimum fare from the card" do
        min_fare = Oystercard::MINIMUM_FARE
        expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_fare)
      end
    end
  end

  context "touch in/saving station" do
    it "remembembers the entry station" do
      expect(card_with_money.touch_in(station)).to eq(station)
    end
  end

  context "touch out/forgetting entry station" do
    it 'forgets entry station' do
      ex_card = card_with_money
      ex_card.touch_in(station)
      expect(ex_card.touch_out(exit_station)).to eq(nil)
    end
  end

end
