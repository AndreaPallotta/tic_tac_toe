local Utils = require("utils")

Board = {size = 3}

local function create_cells(size)
    local cells = {}
    for i = 1, size do
        cells[i] = {}
        for j = 1, size do
            cells[i][j] = ""
        end
    end
    return cells
end

function Board:init()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.cells = create_cells(self.size)

    return o
end

function Board:is_valid_position(row, col, full_check)
    if row < 1 or col < 1 or row > self.size or col > self.size then
        return false
    end

    return not full_check or self.cells[row][col] == ""
end

function Board:get_cell(row, col)
    if not self:is_valid_position(row, col, false) then
        error("Invalid row or column value. Try again")
    end

    return self.cells[row][col]
end

function Board:set_cell(row, col, mark)
    if not self:is_valid_position(row, col, true) then
        error("Invalid row or column value. Try again")
    end

    self.cells[row][col] = mark
end

function Board:display()
    print("\n     c1  c2  c3")
    print("   -------------")

    for i = 1, self.size do
        io.write(Utils.f"r{i} |")
        for j = 1, self.size do
            local cell = self.cells[i][j]
            io.write(" " .. cell .. string.rep(" ", 1 - #cell) .. " |")
        end

        print("\n   -------------")
    end

    print("")
end

function Board:is_full()
    for _, row in ipairs(self.cells) do
        for _, cell in ipairs(row) do
            if cell == "" then
                return false
            end
        end
    end

    return true
end

function Board:has_horizontal_win()
    for _, row in ipairs(self.cells) do
        if row[1] ~= "" and row[1] == row[2] and row[2] == row[3] then
            return true
        end
    end

    return false
end

function Board:has_vertical_win()
    for col = 1, self.size do
        if self.cells[1][col] ~= "" and self.cells[1][col] == self.cells[2][col] and self.cells[2][col] == self.cells[3][col] then
            return true
        end
    end

    return false
end

function Board:has_diagonal_win()
    if (self.cells[1][1] ~= "" and self.cells[1][1] == self.cells[2][2] and self.cells[2][2] == self.cells[3][3]) or
       (self.cells[1][3] ~= "" and  self.cells[1][3] == self.cells[2][2] and self.cells[2][2] == self.cells[3][1]) then
        return true
    end
    return false
end

function Board:check_winner()
    return self:has_horizontal_win() or self:has_vertical_win() or self:has_diagonal_win()
end

function Board:set_remaining_cells()
    for i = 1, self.size do
        for j = 1, self.size do
            if self.cells[i][j] == "" then
                self:set_cell(i, j, Utils.Mark.DEF)
            end
        end
    end
end

return Board