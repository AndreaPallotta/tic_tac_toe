import 'dart:io';

class Mark {
  static const String O = "O";
  static const String X = "X";
}

void clearTerminal() {
  print("\x1B[2J\x1B[H");
}

String getUserName(int playerNum) {
  String defName = "Player $playerNum";

  stdout.write("Insert player $playerNum name (default '$defName'): ");
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    return defName;
  }
  return input;
}

List<String> getUserInput(String playerName) {
  stdout.write("Player $playerName, enter row and column (e.g. '1 2'): ");
  String input = stdin.readLineSync()?.trim() ?? '';

  return input.split(' ');
}

List<int> inputToCoords(List<String> input) {
  if (input.length != 2) {
    throw Exception("Invalid row or column. Try again");
  }

  try {
    int row = int.parse(input[0]);
    int col = int.parse(input[1]);

    return [row - 1, col - 1];
  } catch (_) {
    throw Exception("Invalid row or column. Try again");
  }
}
