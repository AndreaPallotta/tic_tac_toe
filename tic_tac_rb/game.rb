require_relative "board.rb"
require_relative "utils.rb"

class Game
    attr_accessor :player1, :player2, :current_player, :winner, :board

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @current_player = player1
        @winner = nil
        @board = Board.new
    end

    def switch_current_player
        if @current_player.equal?(@player1)
            @current_player = @player2
        elsif @current_player.equal?(@player2)
            @current_player = @player1
        end
    end

    def display
        @board.display
    end

    def is_winner
        @board.check_winner
    end

    def is_draw
        @board.is_full
    end

    def is_over
        if is_draw
            @winner = nil
            @current_player = nil
            puts "Game over! It is a draw!"
            return true
        end

        if is_winner
            @winner = @current_player
            @board.set_remaining_cells
            clear_terminal
            display
            puts "Game over! #{@current_player.name} is the winner"
            return true
        end

        return false
    end

    def make_move
        while true
            begin
                input = get_user_input(@current_player.name)
                row, col = input_to_coords(input)

                @board.set_cell(row - 1, col - 1, @current_player.mark)
                break
            rescue ArgumentError, IndexError => e
                puts e.message
            end
        end
    end

end