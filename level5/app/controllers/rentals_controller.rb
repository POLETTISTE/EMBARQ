require_relative "../views/rentals_view.rb"
require_relative "../repositories/rental_repository.rb"

class RentalsController
  def initialize(rental_repository)
    @rental_repository = rental_repository
    @rentals_view = RentalsView.new
  end

  def add
    start_date = @rentals_view.ask_for_something("START DATE OF YOUR RENTAL? (format yyyy-mm-dd)").to_s
    end_date = @rentals_view.ask_for_something("END DATE OF YOUR RENTAL? (format yyyy-mm-dd)").to_s
    car_id = @rentals_view.ask_for_something("CAR ID?").to_i
    distance = @rentals_view.ask_for_something("DISTANCE YOU WILL TRAVEL WITH THE CAR?").to_i

    rental = Rental.new(
      id: nil,
      start_date: start_date,
      end_date: end_date,
      car_id: car_id,
      distance: distance,
      options: []
    )

    rental.options << @rental_repository.option_gps.keys.first if ask_yes_no_question("Do you want a GPS? (Y/N)")
    rental.options << @rental_repository.option_baby_seat.keys.first if ask_yes_no_question("Do you want a BABY SEAT? (Y/N)")
    rental.options << @rental_repository.option_additional_insurance.keys.first if ask_yes_no_question("Do you want an ADDITIONAL INSURANCE? (Y/N)")

    @rental_repository.create(rental)
  end

  def list
    display_rentals
  end

  private

  def ask_yes_no_question(question)
    response = @rentals_view.ask_for_something(question).downcase

    case response
    when "y", "yes"
      true
    else
      false
    end
  end

  def display_rentals
    rentals = @rental_repository.all
    @rentals_view.display(rentals)
  end
end
