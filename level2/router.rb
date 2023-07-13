class Router
  def initialize(cars_controller, rentals_controller)
    @cars_controller = cars_controller
    @rentals_controller = rentals_controller
    @running = true
  end

  def run
    while @running
      choice = display_menu
      system('clear') || system('cls')  # Clear the console screen
      action(choice)
    end
  end

  def display_menu
    puts '--  WELCOME TO GETAROUND !  --'
    puts '------------------------------'
    puts '----------|  MENU  |----------'
    puts '------------------------------'
    puts 'What do you want to do ?'
    puts '[1] - List all the cars'
    puts '[2] - Add a car'
    puts '[3] - List all rentals'
    puts '[4] - Add a rental'
    puts '------------------------------'
    puts '[9] - Quit'
    print '> '
    gets.chomp.to_i
  end

  def action(choice)
    case choice
    when 1 then @cars_controller.list
    when 2 then @cars_controller.add
    when 3 then @rentals_controller.list
    when 4 then @rentals_controller.add
    when 9 then @running = false
    else
      puts "Please try again"
    end
  end
end
