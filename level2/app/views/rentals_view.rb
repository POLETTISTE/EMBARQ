class RentalsView
  def display(rentals)
    rentals.each do|rental|
      puts "Rental n°#{rental.id}"
      puts "Start date: #{rental.start_date}"
      puts "End date: #{rental.end_date}" 
      puts "Car n° #{rental.car_id.to_i}"
      puts "Distance: #{rental.distance.to_i} km"
      puts "---------------------------------"
      puts "---------------------------------"
    end
  end

  def ask_for_something(stuff)
    puts "#{stuff.capitalize}?"

    return gets.chomp
  end
end