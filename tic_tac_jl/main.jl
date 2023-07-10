include("game.jl")
include("utils.jl")
include("player.jl")

UtilsMod.clear_terminal()
println("Welcome to Tic Tac Jl!\n")

try
    round_counter::Int = 1

    p1_name::String = UtilsMod.get_user_name(1)
    p2_name::String = UtilsMod.get_user_name(2)

    p1 = PlayerMod.Player(p1_name, UtilsMod.O)
    p2 = PlayerMod.Player(p2_name, UtilsMod.X)

    println()

    game::GameMod.Game = GameMod.Game(p1, p2)
    GameMod.display(game)

    while true
        GameMod.make_move(game)

        round_counter += 1
        UtilsMod.clear_terminal()
        println("Here's the updated board. Round $round_counter")

        GameMod.display(game)

        if GameMod.is_over(game)
            break
        end

        GameMod.switch_current_player(game)
        println("It is now $(game.current_player.name) turn!")
    end
catch e
    println("An error has been found: $(e.message)")
end