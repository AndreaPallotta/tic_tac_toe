package tic_tac_kt

fun main() {
    Utils.clearTerminal()
    println("Welcome to Tic Tac Kt!\n")

    try {

        var roundCounter = 1

        val p1Name = Utils.getUserName(1)
        val p2Name = Utils.getUserName(2)

        val p1 = Player(p1Name, Utils.Mark.O)
        val p2 = Player(p2Name, Utils.Mark.X)

        println("")

        val game = Game(p1, p2)

        game.display()

        while (true) {
            game.makeMove()

            roundCounter++
            Utils.clearTerminal()
            println("Here's the updated board. Round $roundCounter")

            game.display()

            if (game.isOver()) break;

            game.switchCurrentPlayer()

            println("It is now ${game.getCurrentPlayer().name} turn!")
        }
    } catch (e: Exception) {
        println("An error has been found: ${e.message}")
    }
}
