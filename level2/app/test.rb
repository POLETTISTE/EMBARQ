require_relative "./models/car.rb"
require_relative "./repositories/car_repository.rb"


car = Car.new(id:1, price_per_day:1000, price_per_km:23)
p car

car_repo = CarRepository.new("./data/input.json", "./data/output.json")
p car_repo