module BoardMod

include("utils.jl")

const SIZE = 3

struct Board
    cells::Matrix{String}

    function Board()
        new(Matrix{String}(fill("", SIZE, SIZE)))
    end
end

function is_valid_position(self::Board, row::Int, col::Int, full_check = true)
    if row < 0 || col < 0 row > SIZE || col > SIZE
        return false
    end

    return !full_check || isempty(self.cells[row, col])
end

function get_cell(self::Board, row::Int, col::Int)
    if !is_valid_position(self, row, col, false)
        throw(ErrorException("Invalid row or column value. Try again"))
    end

    return self.cells[row, col]
end

function set_cell(self::Board, row::Int, col::Int, mark::String)
    if !is_valid_position(self, row, col)
        throw(ErrorException("Invalid row or column value. Try again"))
    end

    self.cells[row, col] = mark
end

function display(self::Board)
    println("\n     c1  c2  c3")
    println("   -------------")

    for i in 1:SIZE
        print("r$i |")
        for j in 1:SIZE
            print("$(lpad(self.cells[i, j], 2)) |")
        end

        println("\n   -------------")
    end

    println("")
end

function is_full(self::Board)
    for row in eachrow(self.cells)
        if any(cell -> isempty(cell), row)
            return false
        end
    end
    return true
end

function has_horizontal_win(self::Board)
    for row in eachrow(self.cells)
        if length(Set(row)) == 1 && !isempty(row[1])
            return true
        end
    end
    
    return false
end

function has_vertical_win(self::Board)
    for col in eachcol(self.cells)
        if length(Set(col)) == 1 && !isempty(col[1])
            return true
        end
    end
    
    return false
end

function has_diagonal_win(self::Board)
    main_diag = [self.cells[i, i] for i in 1:SIZE]
    sec_diag = [self.cells[i, SIZE - i + 1] for i in 1:SIZE]

    main_match::Bool = length(Set(main_diag)) == 1 && !isempty(main_diag[1])
    sec_match::Bool = length(Set(sec_diag)) == 1 && !isempty(sec_diag[1])

    return main_match || sec_match
end

function check_winner(self::Board)
    return has_horizontal_win(self) || has_vertical_win(self) || has_diagonal_win(self)
end

function set_remaining_cells(self::Board)
    for i in 1:SIZE
        for j in 1:SIZE
            if isempty(self.cells[i, j])
                set_cell(self, i, j, UtilsMod.DEF)
            end
        end
    end
end

end