class Board
    SIZE = 3
    attr_accessor :cells

    def initialize
        @cells = Array.new(SIZE) { Array.new(SIZE, '') }
    end

    def is_valid_position(row, col)
        if row < 0 or col < 0 or row >= SIZE or col >= SIZE
            return false
        end

        cell = @cells[row][col]

        return cell.strip.empty?
    end

    def get_cell(row, col)
        if not is_valid_position(row, col)
            raise IndexError, "Invalid row or column value. Try again"
        end
        return @cells[row][col]
    end

    def set_cell(row, col, mark)
        if not is_valid_position(row, col)
            raise IndexError, "Invalid row or column value. Try again"
        end
        @cells[row][col] = mark
    end

    def display
        puts "\n     c1  c2  c3"
        puts "    ------------"

        @cells.each_with_index do |row, i|
            print "r#{i+1} |"
            row.each_with_index do |cell, j|
                print sprintf(" %1s |", cell)
            end

            puts "\n   -------------"
        end

        puts
    end

    def is_full
        @cells.all? { |row| row.none?(&:empty?) }
    end

    def has_horizontal_win
        @cells.any? { |row| row.none?(&:empty?) and row.uniq.length == 1 }
    end

    def has_vertical_win
        @cells.transpose.any? { |col| col.none?(&:empty?) and col.uniq.length == 1 }
    end

    def has_diagonal_win
        main_diagonal = (0...SIZE).map { |i| @cells[i][i] }
        sec_diagonal = (0...SIZE).map { |i| @cells[i][SIZE - i - 1 ] }

        main_match = main_diagonal.none?(&:empty?) and main_diagonal.uniq.length == 1
        sec_match = sec_diagonal.none?(&:empty?) and sec_diagonal.uniq.length == 1

        main_match or sec_match
    end

    def check_winner
        has_horizontal_win or has_vertical_win or has_diagonal_win
    end

    def set_remaining_cells
        @cells.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                if cell.empty?
                    set_cell(i, j, "-")
                end
            end
        end
    end

end