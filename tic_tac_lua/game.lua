local Board = require("board")
local Utils = require("utils")

Game = {}

function Game:init(p1, p2)
    local o = {}
    setmetatable(o, Game)
    self.__index = self
    self.player1 = p1
    self.player2 = p2
    self.current_player = p1
    self.winner = nil
    self.board = Board:init()

    return o
end

function Game:switch_current_player()
    if self.current_player == nil then
        error("Cannot find current player")
    end

    if self.current_player == self.player1 then
        self.current_player = self.player2
    elseif self.current_player == self.player2 then
        self.current_player = self.player1
    end
end

function Game:display()
    self.board:display()
end

function Game:is_winner()
    return self.board:check_winner()
end

function Game:is_draw()
    return self.board:is_full()
end

function Game:is_over()
    if self:is_winner() then
        self.winner = self.current_player
        self.board:set_remaining_cells()
        Utils.clear_terminal()
        self:display()
        print(Utils.f"Game over. {self.current_player.name} is the winner!")
        return true
    end

    if self:is_draw() then
        self.winner = nil
        self.current_player = nil
        print("Game over! It is a draw!")
        return true
    end

    return false
end

function Game:make_move()
    if self.current_player == nil then
        error("Cannt find current player")
    end

    while true do
        local row,col
        local success, err_message = pcall(function ()
            row,col = Utils.get_user_coords(self.current_player.name)
        end)

        if success then
            local set_cell_success, set_cell_err_message = pcall(function ()
                self.board:set_cell(row, col, self.current_player.mark)
            end)
            
            if set_cell_success then
                break
            else
                print(set_cell_err_message)
            end
        else
            print(err_message)
        end
    end
end

return Game