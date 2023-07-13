require_relative "../views/rentals_view.rb"
require_relative "../repositories/rental_repository.rb"

class RentalsController
  def initialize(rental_repository)
    @rental_repository = rental_repository
    @rentals_view = RentalsView.new
  end

  def add
    start_date = @rentals_view.ask_for_something("Start date of rental ( ex: 2024-01-31 ) ")
    end_date = @rentals_view.ask_for_something("End date of rental ( ex: 2024-01-31 ) ")
    car_id = @rentals_view.ask_for_something("ID of the car ").to_i
    distance = @rentals_view.ask_for_something("Distance you will travel ( km ) ").to_i

    rental = Rental.new(start_date: start_date, end_date: end_date, car_id: car_id, distance: distance)
    @rental_repository.create(rental)
  end

  def list
    display_rentals
  end

  private

  def display_rentals
    rentals = @rental_repository.all
    @rentals_view.display(rentals)
  end
end