require 'journey'

describe Journey do

  it "receives an entry station as an argument" do
    expect(subject).to respond_to(:start_journey).with(1).argument
  end

  it "stores and entry station" do
    expect(subject.start_journey("Victoria")).to eq "Victoria"
  end

end