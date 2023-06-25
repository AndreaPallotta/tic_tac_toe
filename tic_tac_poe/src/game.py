from board import Board
from utils import clear_terminal, parse_input


class Game:
    def __init__(self, player1, player2):
        self.player1 = player1
        self.player2 = player2
        self.current_player = player1
        self.winner = None
        self.board = Board(3)

    def get_current_player(self):
        return self.current_player

    def get_board(self):
        return self.board

    def switch_current_player(self):
        self.current_player = self.player2 if self.current_player == self.player1 else self.player1

    def display(self):
        self.board.display()

    def is_winner(self):
        return self.board.check_winner()

    def is_draw(self):
        return self.board.is_full()

    def is_over(self):
        if self.is_draw():
            self.winner = None
            self.current_player = None
            return True

        if self.is_winner():
            self.winner = self.current_player
            clear_terminal()
            self.board.set_remaining_cells()
            return True

        return False

    def announce_draw(self):
        print("It is a draw!")

    def announce_winner(self):
        print(f"{self.winner.get_name()} is the winner!")

    def get_player_move(self):
        while True:
            input_str = input("Player '{}', enter row and column (e.g. '1 2'): ".format(
                self.current_player.get_name()))
            try:
                return parse_input(input_str, self.board)
            except ValueError as ve:
                print(ve)
