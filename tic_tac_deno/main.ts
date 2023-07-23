import Game from "./game.ts";
import Player from "./player.ts";
import { Mark, clearTerminal, getUserName } from "./utils.ts";

clearTerminal()
console.log("Welcome to Tic Tac Deno!\n")

try {
    let roundCounter = 1

    const p1Name = getUserName(1)
    const p2Name = getUserName(2)

    const p1 = new Player(p1Name, Mark.O)
    const p2 = new Player(p2Name, Mark.X)

    console.log()
    
    const game = new Game(p1, p2)
    game.display()

    while (true) {
        game.makeMove()

        roundCounter += 1
        clearTerminal()
        console.log(`Here's the updated board. Round ${roundCounter}`)

        game.display()

        if (game.isOver()) break

        game.switchCurrentPlayer()
        console.log(`It is now ${game.currentPlayer?.name} turn!`)
    }
} catch (e: unknown) {
    console.log(`An error has been found: ${(e as Error).message}`)
}
