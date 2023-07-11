require "./player"
require "./utils"
require "./game"

module TicTacCr
  Utils.clear_terminal
  puts "Welcome to Tic Tac Cr!\n"

  begin
    round_counter = 1
    
    p1_name = Utils.get_user_name(1)
    p2_name = Utils.get_user_name(2)

    p1 = Player.new(p1_name, Utils::O)
    p2 = Player.new(p2_name, Utils::X)

    puts ""

    game = Game.new(p1, p2)
    game.display

    loop do
      game.make_move

      round_counter += 1
      Utils.clear_terminal
      puts "Here's the updated board. Round #{round_counter}"

      game.display

      if game.is_over
        break
      end

      game.switch_current_player

      puts "It is now turn!"
    end

  rescue e
    puts "An error has been found: #{e.message}"
  end
end
