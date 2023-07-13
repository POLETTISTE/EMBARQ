require 'date'
require_relative "../app/models/rental.rb"
require_relative "../app/models/car.rb"
require_relative "../app/repositories/rental_repository.rb"


RSpec.describe Rental do
  describe "#calculate_duration" do
    it "calculates the correct duration in days" do
      rental = Rental.new(start_date: "2022-01-01", end_date: "2022-01-10", distance: 100, car_id: 1)
      
      duration = rental.calculate_duration

      expect(duration).to eq(10)
    end
  end

  describe "#initialize" do
  it "creates a new instance of Rental with the provided attributes" do
    rental = Rental.new(id: 4, start_date: "2022-01-10", end_date: "2022-01-20", distance: 100, car_id: 1)
    expect(rental.id).to eq(4)
    expect(rental.start_date).to eq("2022-01-10")
    expect(rental.end_date).to eq("2022-01-20")
  end

  describe "#calculate_price" do
  it "calculate the correct price" do
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 4, start_date: "2022-01-01", end_date: "2022-01-10", distance: 100, car_id: 1)
    duration = rental.calculate_duration

    price = (car.price_per_day * duration) + (car.price_per_km * rental.distance)


    expect(price).to eq(21000)

  end
end
end
end

