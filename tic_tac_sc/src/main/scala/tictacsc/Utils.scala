package tictacsc

import scala.io.StdIn.readLine

object Utils {
  def clearTerminal = {
    print("\u001b[2J\u001b[H")
  }

  def getUserName(playerNum: Int): String = {
    var defName = s"Player $playerNum"

    print(s"Insert player $playerNum name (default '$defName'): ")
    val input = readLine().trim()

    if ("".equals(input)) {
        return defName
    }
    return input
  }

  def getUserCoords(playerName: String): (Int, Int) = {
    print(s"Player $playerName, enter row and column (e.g. '1 2'): ")
    val input = readLine()
    val inputArr = input.split(" ")

    if (inputArr.length != 2) {
        throw new Exception("Invalid row or column. Try again")
    }

    try {
        val row = inputArr(0).toInt
        val col = inputArr(1).toInt

        return (row - 1, col - 1)
    } catch {
        case _: Throwable => throw new Exception("Invalid row or column. Try again")
    }
    return (0, 0)
  }
}
