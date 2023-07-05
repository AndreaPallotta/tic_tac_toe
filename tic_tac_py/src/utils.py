from enum import Enum


class Mark(Enum):
    X = "X"
    O = "O"


def clear_terminal():
    print("\033c", end="")


def parse_input(input_str, board):
    fields = input_str.strip().split(" ")

    if len(fields) != 2:
        raise ValueError(
            "Invalid Input. Please enter row and column separated by a space.")

    try:
        row = int(fields[0])
        col = int(fields[1])

    except ValueError:
        raise ValueError("Invalid input. Please enter valid row and column.")

    if not board.is_valid_position(row - 1, col - 1):
        raise ValueError("Invalid input. Please enter valid row and column.")

    return [row - 1, col - 1]


def get_player_name(default_name, player_number):
    input_str = input("Insert Player {} name (default '{}'): ".format(
        player_number, default_name)).strip()

    return default_name if input_str == "" else input_str
