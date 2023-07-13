require 'json'
require_relative '../models/rental.rb'
require_relative '../models/car.rb'

class RentalRepository
  def initialize(json_input_file, json_output_file)
    @json_input_file = json_input_file
    @json_output_file = json_output_file
    @rentals = []
    @next_id = 1
    load_json
  end

  def all
    @rentals
  end

  def create(rental)
    rental.id = @next_id
    
    raise "Invalid rental: Distance must be a positive number! / Please add your rental again :)" if rental.distance.to_f < 0
    raise "Invalid rental: Start date must be before End date! / Please add your rental again :)" if rental.start_date > rental.end_date
    raise "Invalid rental: The car you chose does not exist! / Please add your rental again :)" if rental.car_id.to_i > @cars.length
    
    @rentals << rental
    @next_id += 1
    save_in_input_json
  end

  private

  def save_in_input_json
    json_data = @rentals.map do |rental|
      {
        id: rental.id,
        car_id: rental.car_id,
        start_date: rental.start_date,
        end_date: rental.end_date,
        distance: rental.distance
      }
    end

    data = { "rentals" => json_data }

    json_string = File.read(@json_input_file)
    existing_data = JSON.parse(json_string)
    existing_data["rentals"] ||= []
    existing_data["rentals"] = json_data

    json_string = JSON.pretty_generate(existing_data)
    File.write(@json_input_file, json_string)
    save_rental_in_outpout_json
  end

  def save_rental_in_outpout_json
    json_data_rentals = @rentals.map do |rental|
      car = find_car_by_id(rental.car_id)
      price = calculate_price(car, rental)
      { id: rental.id, price: price }
    end

    data = { "rentals" => json_data_rentals }
    json_string = JSON.pretty_generate(data)
    File.write(@json_output_file, json_string)
  end

  def find_car_by_id(car_id)
    @cars.find { |car| car["id"] == car_id }
  end

  def calculate_price(car, rental)
    return 0 if car.nil?
    duration_in_days = rental.calculate_duration
    price = (car["price_per_day"] * duration_in_days) + (car["price_per_km"] * rental.distance)
    price
  end

  def load_json
    json_data = File.read(@json_input_file)
    data = JSON.parse(json_data)
    @cars = data["cars"]
    rentals_data = data['rentals']

    rentals_data.each do |rental_data|
      rental = Rental.new(
        id: rental_data['id'],
        start_date: rental_data['start_date'],
        end_date: rental_data['end_date'],
        car_id: rental_data['car_id'],
        distance: rental_data['distance']
      )
      @rentals << rental
    end

    @next_id = @rentals.last.id + 1 unless @rentals.empty?
    save_rental_in_outpout_json
  end

  def format_date(date)
    parsed_date = Date.parse(date)
    parsed_date.strftime('%Y-%m-%d')
  rescue Date::Error => e
    raise "Invalid car: Date has a bad format! / Please add your rental again :)"
  end  
end
