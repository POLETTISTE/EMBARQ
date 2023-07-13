class Rental
  attr_accessor :id, :start_date, :end_date, :car_id, :distance, :options

  def initialize(id:, start_date:, end_date:, car_id:, distance:, options: [])
    @id = id
    @start_date = start_date
    @end_date = end_date
    @car_id = car_id
    @distance = distance
    @options = options
  end
end
