class CarsView
  def display(cars)
    cars.each do|car|
      puts""
      puts "***********************************************************"
      puts "                       🚗"
      puts "                  CAR ID : #{car.id}"
      puts ""
      puts "               PRICE / DAY : #{(car.price_per_day.to_f / 100).round(2)} €"
      puts "                PRICE / KM : #{(car.price_per_km.to_f / 100).round(2)} €"
      puts ""
      puts "***********************************************************"
      
    end
  end

  def ask_for_something(stuff)
    puts "#{stuff}?"
    return gets.chomp
  end
end