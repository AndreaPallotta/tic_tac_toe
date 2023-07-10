module UtilsMod

const O = "O"
const X = "X"
const DEF = "-"

function clear_terminal()
    print("\x1B[2J\x1B[H");
end

function get_user_name(player_number::Int)
    def_name::String = "Player $player_number"

    print("Insert player $player_number name (default '$def_name'): ")
    input = strip(readline())

    return isempty(input) ? def_name : input
end

function get_user_input(player_name::String)
    print("Player $player_name, enter row and column (e.g. '1 2'): ")
    input::String = strip(readline())

    input_arr::Vector{SubString{String}} = split(input)

    if length(input_arr) != 2
        throw(ErrorException("Invalid row or column. Try again"))
    end

    try
        row::Int = parse(Int, input_arr[1])
        col::Int = parse(Int, input_arr[2])

        return (row, col)
    catch
        throw(ErrorException("Invalid row or column. Try again"))
    end
end

end