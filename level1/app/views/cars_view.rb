class CarsView
  def display(cars)
    cars.each do|car|
      puts "Car n°#{car.id}"
      puts "---------------------------------"
      puts "Price per day: #{car.price_per_day.to_f/100} €"
      puts "Price per km: #{car.price_per_km.to_f/100} €"
      puts "---------------------------------"
      puts "---------------------------------"
    end
  end

  def ask_for_something(stuff)
    puts "#{stuff.capitalize}?"
    return gets.chomp
  end
end