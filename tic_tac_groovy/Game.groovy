class Game {

    private Player player1
    private Player player2
    private Player currentPlayer
    private Player winner
    private Board board

    Game(Player player1, Player player2) {
        this.player1 = player1
        this.player2 = player2
        this.currentPlayer = player1
        this.board = new Board()
    }

    void switchCurrentPlayer() {
        if (this.currentPlayer == null) {
            throw new Exception(Errors.ERR_NO_CURR_PLAYER)
        }

        if (this.currentPlayer == this.player1) {
            this.currentPlayer = this.player2
        } else if (this.currentPlayer == this.player2) {
            this.currentPlayer = this.player1
        }
    }

    void display() {
        this.board.display()
    }

    boolean isWinner() {
        return this.board.checkWinner()
    }

    boolean isDraw() {
        return this.board.isFull()
    }

    boolean isOver() {
        if (this.isWinner()) {
            this.winner = this.currentPlayer
            this.board.setRemainingCells()
            Utils.clearTerminal()
            this.display()
            println("Game over! ${this.winner.name} is the winner!")
            return true
        }

        if (this.isDraw()) {
            this.winner = null
            this.currentPlayer = null
            println('Game over! It is a draw!')
            return true
        }

        return false
    }

    void makeMove() {
        if (this.currentPlayer == null) {
            throw new Exception(Errors.ERR_NO_CURR_PLAYER)
        }

        while (true) {
            try {
                Tuple2<Integer, Integer> coords = Utils.getUserCoords(this.currentPlayer.name)
                this.board.setCell(coords.first, coords.second, this.currentPlayer.mark)
                break
            } catch (Exception e) {
                println(e.getMessage())
            }
        }
    }
}