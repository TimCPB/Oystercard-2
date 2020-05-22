require 'journey'

describe Journey do
  let(:journey) { [{entry: "Angel", exit: "Bond" }] }

  it "receives an entry station as an argument" do
    expect(subject).to respond_to(:start_journey).with(1).argument
  end

  it "stores and entry station" do
    expect(subject.start_journey("Victoria")).to eq "Victoria"
  end

  it "receives an exit station as an argument" do
    expect(subject).to respond_to(:end_journey).with(1).argument
  end

  it "stores an exit station" do
    expect(subject.end_journey("Angel")).to eq "Angel"
  end

  it "Adds the complete journey details to list" do
    subject.start_journey("Angel")
    subject.end_journey("Bond")
    expect(subject.list_of_journeys).to eq journey
  end

end