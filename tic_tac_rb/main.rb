#!/usr/bin/ruby

require_relative "utils.rb"
require_relative "player.rb"
require_relative "game.rb"

def main
    clear_terminal
    puts "Welcome to Tic Tac Rb!\n"

    begin
        round_counter = 1

        p1_name = get_user_name(1)
        p2_name = get_user_name(2)

        p1 = Player.new(p1_name, Mark::O)
        p2 = Player.new(p2_name, Mark::X)

        game = Game.new(p1, p2)

        game.display

        loop do
            game.make_move

            round_counter += 1
            clear_terminal
            puts "Here's the updated board. Round #{round_counter}\n"

            game.display
        
            break if game.is_over

            game.switch_current_player

            puts "It is now #{game.current_player.name} turn!"
        end

        puts "Game over!"
        
    rescue => e
        puts "An error has been found: #{e.message}"
    end
end

main