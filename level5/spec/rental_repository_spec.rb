require_relative '../app/repositories/rental_repository.rb'
require_relative '../app/models/rental.rb'
require_relative '../app/models/car.rb'

describe RentalRepository do
  let(:repository) { RentalRepository.new("./app/data/input.json", "./app/data/output.json") }

  describe "#calculate_discount" do
    it "returns the correct discount for each day" do
      expect(repository.calculate_discount(1)).to eq(1)
      expect(repository.calculate_discount(2)).to eq(0.9)
      expect(repository.calculate_discount(5)).to eq(0.7)
      expect(repository.calculate_discount(11)).to eq(0.5)
    end
  end

  describe "#calculate_duration" do
    it "calculates the correct duration in days" do
      start_date = "2022-01-01"
      end_date = "2022-01-01"

      duration = repository.calculate_duration(start_date, end_date)

      expect(duration).to eq(1)
    end
  end

  describe "#calculate_price" do
    it "calculates the correct price for a rental" do
      car = { "id" => 1, "price_per_day" => 2000, "price_per_km" => 10 }
      rental = Rental.new(id: 1, start_date: "2015-12-08", end_date: "2015-12-08", car_id: 1, distance: 100)

      expect(repository.calculate_price(car, rental)).to eq(3000)
    end
  end

end
