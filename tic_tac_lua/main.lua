local Player = require("player")
local Utils = require("utils")
local Game = require("game")

Utils.clear_terminal()
print("Welcome to Tic Tac Lua!\n")

local round_counter = 1
local p1_name = Utils.get_username(1)
local p2_name = Utils.get_username(2)

local p1 = Player.init(p1_name, Utils.Mark.O)
local p2 = Player.init(p2_name, Utils.Mark.X)

print("")

local game = Game:init(p1, p2)
game:display()


while true do
    game:make_move()
    round_counter = round_counter + 1
    Utils.clear_terminal()
    print(Utils.f"Here's the updated board. Round {round_counter}")

    game:display()

    if game:is_over() then
        break
    end

    game:switch_current_player()

    print(Utils.f"It is now {game.current_player.name} turn!")
end