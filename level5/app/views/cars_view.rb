class CarsView
  def display(cars)
    cars.each do|car|
      puts""
      puts "***********************************************************"
      puts "                       🚗"
      puts "                  CAR ID : #{car.id}"
      puts ""
      puts "               PRICE / DAY : #{sprintf('%.2f', car.price_per_day.to_f / 100)} €"
      puts "               PRICE / KM : #{sprintf('%.2f', car.price_per_km.to_f / 100)} €"
      puts ""
      puts "***********************************************************"
      
    end
  end

  def ask_for_something(stuff)
    puts "#{stuff}?"
    return gets.chomp
  end
end