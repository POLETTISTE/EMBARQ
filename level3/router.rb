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
    puts ""
    puts '┌───────────────────────────────┐'
    puts '│    WELCOME TO GETAROUND !     │'
    puts '├───────────────────────────────┤'
    puts '│           MENU                │'
    puts '├───────────────────────────────┤'
    puts '│   HOW CAN I HELP YOU ?        │'
    puts '├───────────────────────────────┤'
    puts '│   [ 1 ] - LIST ALL CARS       │'
    puts '│   [ 2 ] - ADD A CAR           │'
    puts '│   [ 3 ] - LIST ALL BOOKINGS   │'
    puts '│   [ 4 ] - BOOK A CAR          │'
    puts '├───────────────────────────────┤'
    puts '│   [ 0 ] - Quit                │'
    puts '└───────────────────────────────┘'
    print '> '
    
    gets.chomp.to_i
  end

  def action(choice)
    case choice
    when 1 then @cars_controller.list
    when 2 then @cars_controller.add
    when 3 then @rentals_controller.list
    when 4 then @rentals_controller.add
    when 0 then @running = false
    else
      puts "Please try again"
    end
  end
end
