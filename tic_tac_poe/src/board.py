class Board:
    def __init__(self, size=3):
        self.size = size
        self.cells = [["   "] * size for _ in range(size)]

    def get_size(self):
        return self.size

    def get_cells(self):
        return self.cells

    def is_valid_position(self, row, col):
        if row < 0 or row >= self.size or col < 0 or col >= self.size:
            return False

        if self.cells[row][col].strip() != "":
            return False

        return True

    def set_cell(self, row, col, mark):
        if not self.is_valid_position(row, col):
            raise ValueError("Invalid row or column value. Try again")

        self.cells[row][col] = f" {mark.value} "

    def display(self):
        print("      c1  c2  c3")
        print("    -------------")

        for i in range(len(self.cells)):
            print("r{}  |".format(i + 1), end="")

            for j in range(len(self.cells[i])):
                print(self.cells[i][j], end="|")

            print()

            if i < 2:
                print("    -------------")
            print("    -------------")

    def is_full(self):
        return all(cell.strip() not in ("", "-") for row in self.cells for cell in row)

    def has_horizontal_win(self):
        for row in self.cells:
            trimmed_row = [cell.strip() for cell in row]
            if len(set(trimmed_row)) == 1 and "" not in trimmed_row:
                return True
        return False

    def has_vertical_win(self):
        for col in zip(*self.cells):
            trimmed_col = [cell.strip() for cell in col]
            if len(set(trimmed_col)) == 1 and "" not in trimmed_col:
                return True
        return False

    def has_diagonal_win(self):
        if self.cells[0][0].strip() != "" and all(self.cells[i][i].strip() == self.cells[0][0].strip() for i in range(self.size)):
            return True
        if self.cells[0][self.size - 1].strip() != "" and all(self.cells[i][self.size - i - 1].strip() == self.cells[0][self.size - 1].strip() for i in range(self.size)):
            return True
        return False

    def check_winner(self):
        return self.has_horizontal_win() or self.has_vertical_win() or self.has_diagonal_win()

    def set_remaining_cells(self):
        self.cells[:] = [[" - " if cell.strip() == "" else cell for cell in row]
                         for row in self.cells]
