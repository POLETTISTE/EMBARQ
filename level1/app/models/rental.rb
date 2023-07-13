require 'date'

class Rental
  attr_accessor :id
  attr_reader :start_date, :end_date, :car_id, :distance

  def initialize(attributes = {})
    @id = attributes[:id]
    @start_date = format_date(attributes[:start_date])
    @end_date = format_date(attributes[:end_date])
    @car_id = attributes[:car_id]
    @distance = attributes[:distance]
  end

  def format_date(date)
    parsed_date = Date.parse(date)
    parsed_date.strftime('%Y-%m-%d')
  rescue Date::Error => e
    raise "Invalid car: Date has a bad format! / Please add your rental again :)"
  end
  
  def calculate_duration
    (Date.parse(end_date) - Date.parse(start_date)).to_i + 1
  end
end
