require 'station'

describe Station do

  station = Station.new("Brixton", 2)

  it "creates an instance of Station class" do
    expect(station).to be_instance_of Station
  end

  it "knows its name" do
    expect(station.name).to eq("Brixton")
  end

  it "knows its zone" do
    expect(station.zone).to eq(2)
  end

end