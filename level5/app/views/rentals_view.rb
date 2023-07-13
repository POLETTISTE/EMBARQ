class RentalsView
  def display(rentals)
    rentals.each do |rental|
      puts ""
      puts "***********************************************************"
      puts "                       📕"
      puts "                  RENTAL N° #{rental.id}"
      puts ""
      puts "               START DATE: #{(rental.start_date)}"
      puts "                 END DATE: #{(rental.end_date)}"
      puts ""
      puts "          YOUR CAR NUMBER: N°#{rental.car_id.to_i}"
      puts ""
      puts "                 DISTANCE: #{rental.distance.to_i} KM"
      puts ""
      puts "                 OPTIONS:"

      rental.options.each do |option|
        puts "                   - #{option}"
      end

      puts ""
      puts "***********************************************************"
    end
  end

  def ask_for_something(stuff)
    puts "#{stuff}?"
    return gets.chomp
  end
end
