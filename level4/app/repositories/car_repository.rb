require "json"
require_relative "../models/car.rb"

class CarRepository
  def initialize(json_input_file, json_output_file)
    @json_input_file = json_input_file
    @json_output_file = json_output_file
    @cars = []
    @next_id = 1
    load_json
  end

  def all
    @cars
  end

  def create(car)
    car.id = @next_id
    raise "Invalid car: Price per day must be a positive price! / Please add your rental again :)" if car.price_per_day.to_f < 0
    raise "Invalid car: Price per km must be a positive price! / Please add your rental again :)" if car.price_per_km.to_f < 0

    @cars << car
    @next_id += 1
    save_car_in_input_json
  end

  def find(id)
    @cars.find { |car| car.id == id }
  end

  private

  def save_car_in_input_json
    json_data = @cars.map do |car|
      {
        id: car.id,
        price_per_day: car.price_per_day,
        price_per_km: car.price_per_km
      }
    end

    data = { "cars" => json_data }

    json_string = File.read(@json_input_file)
    existing_data = JSON.parse(json_string)
    existing_data["cars"] ||= []
    existing_data["cars"] = json_data

    json_string = JSON.pretty_generate(existing_data)
    File.write(@json_input_file, json_string)
  end


  def load_json
    json_data = File.read(@json_input_file)
    data = JSON.parse(json_data)
    cars_data = data["cars"]

    cars_data.each do |car_data|
      car = Car.new(
        id: car_data["id"],
        price_per_day: car_data["price_per_day"],
        price_per_km: car_data["price_per_km"]
      )
      @cars << car
    end

    @next_id = @cars.last.id + 1 unless @cars.empty?
  end  
end
