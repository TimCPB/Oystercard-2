require 'station'

describe Station do

  station = Station.new("Brixton", 2)

  it "creates an instance of Station class" do
    expect(station).to be_instance_of Station
  end

  it "initializes with a @name instance variable" do
    expect(station.instance_variable_get(:@name)).to eq("Brixton")
  end

  it "initializes with @zone instance variable" do
    expect(station.instance_variable_get(:@zone)).to eq(2)
  end

end