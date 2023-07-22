class Main {

    static void main(String[] args) {
        Utils.clearTerminal()
        println('Welcome to Tic Tac Groovy!\n')

        try {
            int roundCounter = 1

            String p1Name = Utils.getUserName(1)
            String p2Name = Utils.getUserName(2)

            Player p1 = new Player(p1Name, Mark.O)
            Player p2 = new Player(p2Name, Mark.X)

            println("")

            Game game = new Game(p1, p2)
            game.display()

            while (true) {
                game.makeMove()

                roundCounter++
                Utils.clearTerminal()
                println("Here's the updated board. Round ${roundCounter}")

                game.display()

                if (game.isOver()) {
                    break
                }

                game.switchCurrentPlayer()
                println("It is now ${game.currentPlayer.name} turn!")
            }

        } catch (Exception e) {
            String msg = Errors.ERR_GENERIC(e.getMessage())
            println("An error has been found: ${msg}")
        }
    }

}
