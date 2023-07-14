package tictacsc
import util.control.Breaks._

object Main {

  breakable {

  }

  def main(args: Array[String]) {
    Utils.clearTerminal
    println("Welcome to Tic Tac Sc!\n");

    try {
      var roundCounter = 1

      val p1Name = Utils.getUserName(1)
      val p2Name = Utils.getUserName(2)

      val p1 = new Player(p1Name, Mark.O)
      val p2 = new Player(p2Name, Mark.X)

      println("")

      val game = new Game(p1, p2)
      game.display

      breakable {
        while (true) {
          game.makeMove

          roundCounter += 1
          Utils.clearTerminal
          println(s"Here's the updated board. Round $roundCounter")

          game.display

          if (game.isOver) break

          game.switchCurrentPlayer
          print(s"It is now ${game.getCurrentPlayer().name} turn!")
        }
      }

    } catch {
      case e: Throwable => println(s"An error has been found: ${e.getMessage()}")
    }
  }
}
