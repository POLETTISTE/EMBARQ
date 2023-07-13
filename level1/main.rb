require_relative "./app/controllers/cars_controller.rb"
require_relative "./app/repositories/car_repository.rb"
require_relative "./app/controllers/rentals_controller.rb"
require_relative "./app/repositories/rental_repository.rb"
require_relative "./router.rb"

car_repository = CarRepository.new("./app/data/input.json","./app/data/output.json")
cars_controller = CarsController.new(car_repository)
rental_repository = RentalRepository.new("./app/data/input.json","./app/data/output.json")
rentals_controller = RentalsController.new(rental_repository)

router = Router.new(cars_controller, rentals_controller)
router.run