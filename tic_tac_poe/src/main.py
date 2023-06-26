import utils
from player import Player
from game import Game


def main():
    try:
        p1_name = utils.get_player_name("Player 1", 1)
        p2_name = utils.get_player_name("Player 2", 2)

        p1 = Player(p1_name, utils.Mark.O)
        p2 = Player(p2_name, utils.Mark.X)

        game = Game(p1, p2)
        game.display()

        round_counter = 1

        while not game.is_over():
            [x, y] = game.get_player_move()

            is_valid = game.get_current_player().make_move(game.get_board(), x, y)
            if not is_valid:
                print("Invalid move. Try again")
                continue

            round_counter += 1
            utils.clear_terminal()
            print(f"Here's the updated board. Round {round_counter}")
            print()

            game.display()

            if game.is_over():
                break

            game.switch_current_player()
            print(f"\nIt is now {game.get_current_player().get_name()} turn!")

        print("Game over!")

        game.announce_draw() if game.is_draw() else game.announce_winner()

    except Exception:
        exit(1)


if __name__ == "__main__":
    utils.clear_terminal()
    print("Welcome to Tic Tac Joe!")

    main()
