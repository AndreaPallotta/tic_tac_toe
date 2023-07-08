import 'package:tic_tac_dart/game.dart';
import 'package:tic_tac_dart/player.dart';
import 'package:tic_tac_dart/utils.dart';

void main() {
  clearTerminal();
  print("Welcome to Tic Tac Dart!\n");

  try {
    int roundCounter = 1;

    String p1Name = getUserName(1);
    String p2Name = getUserName(2);

    Player p1 = Player(p1Name, Mark.O);
    Player p2 = Player(p2Name, Mark.X);

    print("");

    Game game = Game(p1, p2);
    game.display();

    while (true) {
      game.makeMove();

      roundCounter++;
      clearTerminal();
      print("Here's the updated board. Round $roundCounter");

      game.display();

      if (game.isOver()) break;

      game.switchCurrentPlayer();

      print("It is now ${game.currentPlayer?.name} turn!");
    }
  } catch (e) {
    print("An error has been found: ${e.toString()}");
  }
}
