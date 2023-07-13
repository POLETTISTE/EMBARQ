require 'json'
require 'date'
require_relative '../models/rental.rb'

class RentalRepository
  attr_reader :rentals

  def initialize(json_input_file, json_output_file)
    @json_input_file = json_input_file
    @json_output_file = json_output_file
    @rentals = []
    @next_id = 1
    @commission = 0.30
    @commission_assistance = 0
    @commission_insurance = 0
    @commission_drivy = 0
    @duration = 0
    
    load_json
  end

  def all
    @rentals
  end

  def find_car_by_id(car_id)
    @cars.find { |car| car["id"] == car_id }
  end

  def create(rental)
    rental.id = @next_id

    raise "Invalid rental: Distance must be a positive number! / Please add your rental again :)" if @distance.to_i < 0
    raise "Invalid rental: Start date must be before or equal to End date! / Please add your rental again :)" if format_date(rental.start_date) > format_date(rental.end_date)
    raise "Invalid rental: Invalid date format. Please use the format YYYY-MM-DD." unless rental.start_date.match?(/^\d{4}-\d{2}-\d{2}$/) && rental.end_date.match?(/^\d{4}-\d{2}-\d{2}$/)
    raise "Invalid rental: The car you chose does not exist! / Please add your rental again :)" if rental.car_id.to_i > @cars.length

    @rentals << rental
    @next_id += 1
    save_rental_in_input_json
  end

  def calculate_price(car, rental)
    return 0 if car.nil?

    duration_in_days = calculate_duration(rental.start_date, rental.end_date).to_i
    price_per_day = car["price_per_day"]

    total_price = 0
    (1..duration_in_days).each do |day|
      discount = calculate_discount(day)
      daily_price = price_per_day * discount
      total_price += daily_price
    end

    total_price += car["price_per_km"] * rental.distance
    @price = total_price.to_i
  end

  def calculate_discount(day)
    case day
    when 1
      1
    when 2..4
      0.9
    when 5..10
      0.7
    else
      0.5
    end
  end

  def format_date(date)
    parsed_date = Date.parse(date.to_s)
    Date.new(parsed_date.year, parsed_date.month, parsed_date.day)
  end

  def calculate_duration(first_date, last_date)
    formatted_first_date = format_date(first_date)
    formatted_last_date = format_date(last_date)
    @duration = (formatted_last_date - formatted_first_date).to_i + 1
  end


  def calculate_commission_insurance_fee
    @commission_insurance = @price * @commission * 50 / 100
    @commission_insurance.to_i
  end

  def calculate_commission_assistance_fee
    @commission_assistance = @duration * 100
    @commission_assistance.to_i
  end
  

  def calculate_commission_drivy_fee
    @commission_drivy = @price * @commission - @commission_insurance - @commission_assistance
    @commission_drivy.to_i
  end

  def calculate_owner_amount
   @owner_amount =  @price * 70 / 100
   @owner_amount.to_i
  end

  private

  def save_rental_in_input_json
    json_data = @rentals.map do |rental|
      {
        id: rental.id,
        car_id: rental.car_id,
        start_date: rental.start_date,
        end_date: rental.end_date,
        distance: rental.distance,
        options: rental.options
      }
    end

    data = { "rentals" => json_data }

    json_string = File.read(@json_input_file)
    existing_data = JSON.parse(json_string)
    existing_data["rentals"] ||= []
    existing_data["rentals"] = json_data

    json_string = JSON.pretty_generate(existing_data)
    File.write(@json_input_file, json_string)
    save_rental_in_output_json
  end

  def save_rental_in_output_json
    json_data_rentals = @rentals.map do |rental|
      car = find_car_by_id(rental.car_id)
      price = calculate_price(car, rental)
      {
        id: rental.id,
        options: [],
        actions: 
        [
          {
          who: "driver",
          type: "debit",
          amount: @price
          },
          {
            who: "owner",
            type: "credit",
            amount: calculate_owner_amount
          }, 
          {
            who: "insurance",
            type: "credit",
            amount: calculate_commission_insurance_fee
          },
          {
            who: "assistance",
            type: "credit",
            amount: calculate_commission_assistance_fee
          },
          {
            who: "drivy",
            type: "credit",
            amount: calculate_commission_drivy_fee
          }
        ]
      }
    end
    data = { "rentals" => json_data_rentals }
    json_string = JSON.pretty_generate(data)
    File.write(@json_output_file, json_string)
  end

  def load_json
    json_data = File.read(@json_input_file)
    data = JSON.parse(json_data)
    @cars = data["cars"]
    rentals_data = data['rentals']

    rentals_data.each do |rental_data|
      rental = Rental.new(
        id: rental_data['id'],
        start_date: format_date(rental_data['start_date']),
        end_date: format_date(rental_data['end_date']),
        car_id: rental_data['car_id'],
        distance: rental_data['distance']
      )
      @rentals << rental
    end
    @next_id = @rentals.last.id + 1 unless @rentals.empty?
    save_rental_in_output_json
  end
end
