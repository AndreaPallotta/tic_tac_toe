require "./player"
require "./board"
require "./utils"

class Game
    @player1 : Player
    @player2 : Player
    getter current_player : (Player)?
    getter winner : (Player)?
    @board : Board

    def initialize(player1 : Player, player2 : Player)
        @player1 = player1
        @player2 = player2
        @current_player = player1
        @board = Board.new
    end

    def switch_current_player
        if @current_player == nil
            raise "Cannot find current player"
        end

        if @current_player == @player1
            @current_player = @player2
        elsif @current_player == @player2
            @current_player = @player1
        end
    end

    def display
        @board.display
    end

    def is_winner
        return @board.check_winner
    end

    def is_draw
        return @board.is_full
    end

    def is_over
        if is_winner
            if curr_player = @current_player
                @winner = @current_player
                @board.set_remaining_cells
                Utils.clear_terminal
                puts "Game over! #{curr_player.name} is the winner!"
            end
            return true
        end

        if is_draw
            @winner = nil
            @current_player = nil
            puts "Game over! It is a draw!"
            return true
        end

        return false
    end

    def make_move
        if curr_player = @current_player
            loop do
                begin
                    coords = Utils.get_user_coords(curr_player.name)
                    @board.set_cell(coords[0], coords[1], curr_player.mark)
                    break
                rescue e
                    puts e.message
                end
            end
        else
            raise "Cannot find current player"
        end
    end
end