class Rental
  attr_accessor :id, :start_date, :end_date, :car_id, :distance

  def initialize(id:, start_date:, end_date:, car_id:, distance:)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @car_id = car_id
    @distance = distance
  end
end
