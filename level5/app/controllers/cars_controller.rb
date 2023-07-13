
require_relative "../views/cars_view.rb"
require_relative "../repositories/car_repository.rb"

class CarsController
  def initialize(car_repository)
    @car_repository = car_repository
    @cars_view = CarsView.new
  end

  def add
    price_per_day = @cars_view.ask_for_something("WHAT'S YOUR CAR PRICE PER DAY  ? ( € ) ").to_i
    price_per_km = @cars_view.ask_for_something("WHAT'S YOUR CAR PRICE PER KILOMETER  ? ( € )").to_i
    car = Car.new(price_per_day: price_per_day.to_i * 100, price_per_km: price_per_km.to_i * 100)
    @car_repository.create(car)
  end

  def list
    display_cars
  end

  private

  def display_cars
    cars = @car_repository.all
    @cars_view.display(cars)
  end
end