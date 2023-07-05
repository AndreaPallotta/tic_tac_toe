import Game from "./game.js";
import Player from "./player.js";
import { Mark, clearTerminal, getPlayerName } from "./utils.js";


const main = async () => {
    clearTerminal();

    try {
        const p1Name = await getPlayerName("Player 1", 1);
        const p2Name = await getPlayerName("Player 2", 2);

        const p1 = new Player(p1Name, Mark.O);
        const p2 = new Player(p2Name, Mark.X);

        const game = new Game(p1, p2);
        game.display();

        let roundCounter = 1;

        while (!game.isOver()) {
            const [x, y] = await game.getPlayerMove();

            const isValid = game.getCurrentPlayer().makeMove(game.getBoard(), x, y);

            if (!isValid) {
                console.log("Invalid move. Try again");
                continue;
            }

            roundCounter += 1;
            clearTerminal();

            console.log(`Here's the updated board. Round ${roundCounter}`);
            console.log();

            game.display();

            if (game.isOver()) break;

            game.switchCurrentPlayer();
            console.log();
            console.log(`It is now ${game.getCurrentPlayer().getName()} turn!`)
        }

        console.log("Game over!");

        if (game.isDraw()) {
            game.announceDraw();
        } else {
            game.announceWinner();
        }
    
    } catch (err) {
        console.log(err);
        process.exit(1);
    }
}

main();