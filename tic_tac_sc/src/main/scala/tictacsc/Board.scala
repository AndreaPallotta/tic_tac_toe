package tictacsc

import scala.io.StdIn

class Board(val size: Int = 3) {
  val cells = Array.fill(size, size)("")

  def isValidPosition(row: Int, col: Int, fullCheck: Boolean = true): Boolean = {
    if (row < 0 || col < 0 || row >= size || col >= size) {
        return false
    }
    return !fullCheck || cells(row)(col).isEmpty
  }

  def getCell(row: Int, col: Int): String = {
    if (!isValidPosition(row, col, false)) {
        throw new Exception("Invalid row or column value. Try again")
    }

    return cells(row)(col)
  }

  def setCell(row: Int, col: Int, mark: String) = {
    if (!isValidPosition(row, col)) {
        throw new Exception("Invalid row or column value. Try again")
    }

    cells(row)(col) = mark
  }

  def display = {
    println("\n     c1  c2  c3")
    println("   -------------")

    for (i <- 0 until size) {
        print(s"r${i + 1} |")
        for (j <- 0 until size) {
            print(f"${cells(i)(j).toString()}%2s |")
        }

        println("\n   -------------")
    }
    println("")
  }

  def isFull: Boolean = {
    return !cells.flatten.exists(_.isEmpty)
  }

  def hasHorizontalWin: Boolean = {
    return cells.exists(row => row.toSet.size == 1 && !row.head.isEmpty)
  }

  def hasVerticalWin: Boolean = {
    return cells.transpose.exists(column => column.toSet.size == 1 && !column.head.isEmpty)
  }

  def hasDiagonalWin: Boolean = {
    val mainDiag = (0 until size).map(i => cells(i)(i))
    val secDiag = (0 until size).map(i => cells(i)(size - i - 1))

    val mainMatch = mainDiag.toSet.size == 1 && !mainDiag.head.isEmpty
    val secMatch = secDiag.toSet.size == 1 && !secDiag.head.isEmpty

    return mainMatch || secMatch
  }

  def checkWinner: Boolean = {
    return hasHorizontalWin || hasVerticalWin || hasDiagonalWin
  }

  def setRemainingCells = {
    for (i <- 0 until size) {
        for (j <- 0 until size) {
            if ("".equals(cells(i)(j))) {
                setCell(i, j, Mark.DEF)
            }
        }
    }
  }
}
