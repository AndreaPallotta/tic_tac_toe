module GameMod

include("./utils.jl")
include("./player.jl")
include("./board.jl")

mutable struct Game
    player1
    player2
    current_player
    winner
    board

    function Game(p1, p2)
        new(p1, p2, p1, nothing, BoardMod.Board())
    end
end

function switch_current_player(self::Game)
    if isnothing(self.current_player)
        throw(ErrorException("Cannot find current player"))
    end

    if self.current_player == self.player1
        self.current_player = self.player2
    elseif self.current_player == self.player2
        self.current_player = self.player1
    end
end

function display(self::Game)
    BoardMod.display(self.board)
end

function is_winner(self::Game)
    BoardMod.check_winner(self.board)
end

function is_draw(self::Game)
    BoardMod.is_full(self.board)
end

function is_over(self::Game)
    if is_winner(self)
        self.winner = self.current_player
        BoardMod.set_remaining_cells(self.board)
        UtilsMod.clear_terminal()
        display(self)
        println("Game over. $(self.current_player.name) is the winner!")
        return true
    end

    if is_draw(self)
        self.winner = nothing
        self.current_player = nothing
        println("Game over! It is a draw!")
        return true
    end

    return false
end

function make_move(self::Game)
    if isnothing(self.current_player)
        throw(ErrorException("Cannot find current player"))
    end

    while true
        try
            row, col = UtilsMod.get_user_input(self.current_player.name)
            BoardMod.set_cell(self.board, row, col, self.current_player.mark)
            break
        catch e
            println(e)
        end
    end
end

end