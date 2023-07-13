class RentalsView
  def display(rentals)
    rentals.each do |rental|
      puts ""
      puts "***********************************************************"
      puts "                       📅"
      puts "                  RENTAL N° #{rental.id}"
      puts ""
      puts "                   CAR : N° #{rental.car_id.to_i}"
      puts ""
      puts "               FROM : #{rental.start_date}"
      puts "                 TO : #{rental.end_date}"
      puts ""
      puts ""
      puts "               DISTANCE : #{rental.distance.to_i} KM"
      puts ""
      puts ""
      puts "                      OPTIONS :"
      rental.options.each do |option|
        option_with_spaces = option.gsub("_", " ").upcase
      puts "                  -- #{option_with_spaces} --"
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
