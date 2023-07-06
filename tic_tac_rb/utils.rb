class Mark
    O = "O"
    X = "X"
end

def clear_terminal
    puts "\x1B[2J\x1B[H"
end

def get_user_name(player_num)
    def_name = "Player #{player_num}"
    print "Insert Player #{player_num} name (default '#{def_name}'): "

    input = gets.chomp.strip

    if input.empty?
        input = def_name
    end

    return input;
end

def get_user_input(player_name)
    print "Player #{player_name}, enter row and column (e.g. '1 2'): "

    input = gets.chomp.strip.split

    return input
end

def input_to_coords(input)
    if input.length != 2
        raise ArgumentError, "Invalid row or column. Try again"
    end

    begin
        row = Integer(input[0])
        col = Integer(input[1])

        return row, col
    rescue
        raise ArgumentError, "Invalid row or column. Try again"
    end
end

