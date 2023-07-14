package tictacsc

import util.control.Breaks._

class Game(val player1: Player, val player2: Player) {
    var currentPlayer: Option[Player] = Some(player1)
    var winner: Option[Player] = None
    val board: Board = new Board()

    def getCurrentPlayer(): Player = {
        currentPlayer match {
            case Some(player) => player
            case None => 
                throw new Exception("Cannot find current Player")
        }
    }

    def switchCurrentPlayer = {
        val currPlayer = getCurrentPlayer()

        if (currPlayer == player1) currentPlayer = Some(player2)
        else if (currPlayer == player2) currentPlayer = Some(player1)
    }

    def display = {
        board.display
    }

    def isWinner: Boolean = {
        return board.checkWinner
    }

    def isDraw: Boolean = {
        return board.isFull
    }

    def isOver: Boolean = {
        if (isWinner) {
            val currPlayer = getCurrentPlayer()
            winner = Some(currPlayer)
            Utils.clearTerminal
            board.setRemainingCells
            display
            println(s"Game over! ${currPlayer.name} is the winner!")
            return true
        }

        if (isDraw) {
            currentPlayer = None
            winner = None
            println("Game over! It is a draw!")
            return true
        }

        return false
    }

    def makeMove: Unit = {
        val currPlayer = getCurrentPlayer()
        var isMoveMade = false

        def tryMakeMove: Unit = {
            try {
                val (row, col) = Utils.getUserCoords(currPlayer.name)
                board.setCell(row, col, currPlayer.mark)
                isMoveMade = true
            } catch {
                case e: Throwable =>
                    println(e.getMessage)
                    tryMakeMove
            }
        }

        while (!isMoveMade) {
            tryMakeMove
        }
    }
}
