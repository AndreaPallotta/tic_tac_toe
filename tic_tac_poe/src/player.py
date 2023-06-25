class Player:
    def __init__(self, name, mark):
        self.name = name
        self.mark = mark

    def get_name(self):
        return self.name

    def get_mark(self):
        return self.mark

    def make_move(self, board, row, col):
        try:
            board.set_cell(row, col, self.mark)
            return True
        except Exception:
            return False
