import java.io.BufferedReader;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) {
        Utils.clearTerminal();
        System.out.println("Welcome to Tic Tac Java!");

        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

            String p1Name = Utils.getPlayerName(reader, "Player 1", 1);
            String p2Name = Utils.getPlayerName(reader, "Player 2", 2);

            Player p1 = new Player(p1Name, Mark.O);
            Player p2 = new Player(p2Name, Mark.X);

            Game game = new Game(p1, p2);
            game.display();

            int roundCounter = 1;

            while (!game.isOver()) {
                int[] move = game.getPlayerMove();

                boolean isValid = game.getCurrentplayer().makeMove(game.getBoard(), move[0], move[1]);

                if (!isValid) {
                    System.out.println("Invalid move. Try again");
                    continue;
                }
		
		roundCounter++;
                Utils.clearTerminal();
                System.out.println("Here's the updated board. Round " + roundCounter);
                System.out.println();

                game.display();
                if (game.isOver()) {
                    break;
                }

                game.switchCurrentPlayer();
                System.out.printf("\nIt is now %s turn!\n", game.getCurrentplayer().getName());
            }

            System.out.println("Game over!");

            if (game.isDraw()) {
                game.announceDraw();
            } else {
                game.announceWinner();
            }
        } catch (Exception e) {
            //
        }
    }
}
