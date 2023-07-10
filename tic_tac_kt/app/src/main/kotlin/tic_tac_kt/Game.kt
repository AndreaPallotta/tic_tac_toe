package tic_tac_kt

class Game(val player1: Player, val player2: Player) {
    private var currentPlayer: Player? = player1
    private var winner: Player? = null
    private var board = Board()

    public fun getCurrentPlayer(): Player {
        return requireNotNull(this.currentPlayer) { "Cannot find current player" }
    }

    public fun switchCurrentPlayer() {
        val currPlayer = getCurrentPlayer()

        if (currPlayer.equals(player1)) {
            currentPlayer = player2
        } else if (currPlayer.equals(player2)) {
            currentPlayer = player1
        }
    }

    public fun display() {
        board.display()
    }

    public fun isWinner(): Boolean {
        return board.checkWinner()
    }

    public fun isDraw(): Boolean {
        return board.isFull()
    }

    public fun isOver(): Boolean {
        if (isWinner()) {
            winner = currentPlayer
            board.setRemainingCells()
            Utils.clearTerminal()
            display()
            println("Game over! ${currentPlayer?.name} is the winner!")
            return true
        }

        if (isDraw()) {
            winner = null
            currentPlayer = null
            println("Game over! It is a draw!")
            return true
        }

        return false
    }

    public fun makeMove() {
        while (true) {
            try {
                val currPlayer = getCurrentPlayer()
                val coords = Utils.getCoords(currPlayer.name)

                board.setCell(coords.first, coords.second, currPlayer.mark)
                break
            } catch (e: Exception) {
                println(e.message)
            }
        }
    }
}