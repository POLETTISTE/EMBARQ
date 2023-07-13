require_relative '../app/models/rental.rb'

RSpec.describe Rental do


  describe "#initialize" do
    it "creates a new instance of Rental with the provided attributes" do
      rental = Rental.new(id: 4, start_date: "2022-01-10", end_date: "2022-01-20", distance: 100, car_id: 1)
      expect(rental.id).to eq(4)
      expect(rental.start_date).to eq("2022-01-10")
      expect(rental.end_date).to eq("2022-01-20")
    end
  end
end
