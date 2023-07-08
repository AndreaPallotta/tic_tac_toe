import 'package:tic_tac_dart/board.dart';
import 'package:tic_tac_dart/player.dart';
import 'package:tic_tac_dart/utils.dart';

class Game {
  Player player1;
  Player player2;
  Player? currentPlayer;
  Player? winner;
  Board board = Board();

  Game(this.player1, this.player2) {
    currentPlayer = player1;
  }

  void switchCurrentPlayer() {
    if (currentPlayer == null) {
      throw Exception("Cannot find current player");
    }

    if (currentPlayer == player1) {
      currentPlayer = player2;
    } else if (currentPlayer == player2) {
      currentPlayer = player1;
    }
  }

  void display() {
    board.display();
  }

  bool isWinner() {
    return board.checkWinner();
  }

  bool isDraw() {
    return board.isFull();
  }

  bool isOver() {
    if (isWinner()) {
      winner = currentPlayer;
      board.setRemainingCells();
      clearTerminal();
      display();
      print("Game over. ${currentPlayer?.name} is the winner!");
      return true;
    }

    if (isDraw()) {
      winner = null;
      currentPlayer = null;
      print("Game over! It is a draw");
      return true;
    }
    return false;
  }

  void makeMove() {
    if (currentPlayer == null) {
        throw Exception("Current player not found");
    }

    while (true) {
        try {
            List<String> input = getUserInput(currentPlayer!.name);
            List<int> coords = inputToCoords(input);

            board.setCell(coords[0], coords[1], currentPlayer!.mark);
            break;
        } catch (e) {
            print(e.toString());
        }
    }
  }
}
