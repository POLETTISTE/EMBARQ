require 'date'
require_relative "../app/models/rental.rb"
require_relative "../app/models/car.rb"

RSpec.describe Car do
  describe "#initialize" do
    it "creates a new instance of Car with the provided attributes" do
      car = Car.new(id: 1, price_per_day: 1000, price_per_km: 23)
      expect(car.id).to eq(1)
      expect(car.price_per_day).to eq(1000)
      expect(car.price_per_km).to eq(23)
    end
  end

end



