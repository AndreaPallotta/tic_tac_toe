import 'dart:io';

class Board {
  static int size = 3;
  List<List<String>> cells = List.generate(size, (_) => List.filled(size, ''));

  Board();

  bool isValidPosition(int row, int col, {bool fullCheck = true}) {
    if (row < 0 || col < 0 || row > size || col > size) {
      return false;
    }

    return !fullCheck || cells[row][col].isEmpty;
  }

  String getCell(int row, int col) {
    if (!isValidPosition(row, col, fullCheck: false)) {
      throw Exception("Invalid row or column value. Try again");
    }

    return cells[row][col];
  }

  void setCell(int row, int col, String mark) {
    if (!isValidPosition(row, col)) {
      throw Exception("Invalid row or column value. Try again");
    }

    cells[row][col] = mark;
  }

  void display() {
    print("\n     c1  c2  c3");
    print("    ------------");

    for (int i = 0; i < size; i++) {
      stdout.write("r${i + 1} |");
      for (int j = 0; j < size; j++) {
        stdout.write("${cells[i][j].toString().padLeft(2).padRight(2)} |");
      }

      print("\n   -------------");
    }

    print("");
  }

  bool isFull() {
    return !cells.every((row) => row.any((cell) => cell.isEmpty));
  }

  bool hasHorizontalWin() {
    return cells.any((row) => row.toSet().length == 1 && row.first.isNotEmpty);
  }

  bool hasVerticalWin() {
    final columns = List.generate(
        size, (index) => List.generate(size, (i) => cells[i][index]));

    return columns
        .any((column) => column.toSet().length == 1 && column.first.isNotEmpty);
  }

  bool hasDiagonalWin() {
    final mainDiag = List.generate(size, (i) => cells[i][i]);
    final secDiag = List.generate(size, (i) => cells[i][size - i - 1]);

    final mainMatch = mainDiag.toSet().length == 1 && mainDiag.first.isNotEmpty;
    final secMatch = secDiag.toSet().length == 1 && secDiag.first.isNotEmpty;

    return mainMatch || secMatch;
  }

  bool checkWinner() {
    return hasHorizontalWin() || hasVerticalWin() || hasDiagonalWin();
  }

  void setRemainingCells() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (cells[i][j].isEmpty) {
          setCell(i, j, "-");
        }
      }
    }
  }
}
