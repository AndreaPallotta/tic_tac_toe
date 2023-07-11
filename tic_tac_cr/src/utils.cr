module Utils
    O = "O"
    X = "X"
    DEF = "-"

    def self.clear_terminal()
        print "\x1B[2J\x1B[H"
    end

    def self.get_user_name(player_num : Int32)
        def_name = "Player #{player_num}"
        print "Insert player #{player_num} name (default '#{def_name}'): "
        input = gets

        if input
            name = input.chomp.strip
            return name.empty? ? def_name : name
        end

        return def_name
    end

    def self.get_user_coords(player_name : String)
        print "Player #{player_name}, enter row and column (e.g. '1 2'): "
        input = gets

        if input
            input_arr = input.chomp.strip.split(" ")

            if input_arr.size != 2
                raise "Invalid row or column. Try again"
            end

            begin
                row = input_arr[0].to_i
                col = input_arr[1].to_i

                return {row - 1, col - 1}
            rescue
                raise "Invalid row or column. Try again"
            end
        end

        raise "Invalid row or column. Try again"
    end
end