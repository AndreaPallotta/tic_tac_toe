require "./utils"

class Board
    @@size = 3
    @cells = Array(Array(String)).new(@@size) { Array(String).new(@@size, "") }

    def initialize
    end

    def is_valid_position(row : Int32, col : Int32, full_check = true)
        if row < 0 || col < 0 || row > @@size || col > @@size
            return false
        end

        return !full_check || @cells[row][col].empty?
    end

    def get_cell(row : Int32, col : Int32)
        if !is_valid_position(row, col, false)
            raise "Invalid row or column. Try again"
        end

        return @cells[row][col]
    end

    def set_cell(row : Int32, col : Int32, mark : String)
        if !is_valid_position(row, col)
            raise "Invalid row or column. Try again"
        end

        @cells[row][col] = mark
    end

    def display
        puts "\n     c1  c2  c3"
        puts "   -------------"

        @cells.each_with_index do |row, i|
            print "r#{i+1} |"
            row.each do |cell|
                print " #{cell.center(1)} |"
            end

            puts "\n   -------------"
        end

        puts ""
    end

    def is_full
        return !@cells.all? { |row| row.any? { |cell| cell.empty? } }
    end

    def has_horizontal_win
        return @cells.any? { |row| row.to_set.size == 1 && !row.first.empty? }
    end

    def has_vertical_win
        (0...@@size).any? do |col|
            @cells.map { |row| row[col] }.to_set.size == 1 && !@cells.first[col].empty?
        end
    end

    def has_diagonal_win
        main_diag = (0...@@size).map { |i| @cells[i][i] }.to_a
        sec_diag = (0...@@size).map { |i| @cells[i][@@size - i - 1] }.to_a

        main_match = main_diag.to_set.size == 1 && !main_diag.first.empty?
        sec_match = sec_diag.to_set.size == 1 && !sec_diag.first.empty?

        return main_match || sec_match
    end

    def check_winner
        return has_horizontal_win || has_vertical_win || has_diagonal_win
    end

    def set_remaining_cells
        @cells.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                if cell.empty?
                    set_cell(i, j, Utils::DEF)
                end
            end
        end
    end
end