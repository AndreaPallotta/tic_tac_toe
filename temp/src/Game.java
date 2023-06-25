import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Game {
    private Board board;
    private Player player1;
    private Player player2;
    private Player currentPlayer;
    private Player winner = null;

    public Game(Player player1, Player player2) {
        this.board = new Board();
        this.player1 = player1;
        this.player2 = player2;
        this.currentPlayer = player1;
    }

    public Player getCurrentplayer() {
        return this.currentPlayer;
    }
    
    public Board getBoard() {
        return this.board;
    }

    public void switchCurrentPlayer() {
        if (this.currentPlayer.equals(this.player1)) {
            this.currentPlayer = this.player2;
        } else if (this.currentPlayer.equals(this.player2)) {
            this.currentPlayer = this.player1;
        }
    }

    public void display() {
        this.board.display();
    }

    public boolean isWinner() {
        return this.board.checkWinner();
    }

    public boolean isDraw() {
        return this.board.isFull();
    }

    public boolean isOver() {
        if (this.isDraw()) {
            this.winner = null;
            this.currentPlayer = null;
            return true;
        }

        if (this.isWinner()) {
            this.winner = this.currentPlayer;
            Utils.clearTerminal();
            this.board.setRemainingCells();
            this.display();
            return true;
        }

        return false;
    }

    public void announceDraw() {
        System.out.println("It is a draw!");
    }

    public void announceWinner() {
        System.out.printf("%s is the winner!\n", this.winner.getName());
    }

    public int[] getPlayerMove() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

        while (true) {
            System.out.printf("Player '%s', enter row and column (e.g. '1 2'): ", this.currentPlayer.getName());
            String input = reader.readLine();

            try {
                return Utils.parseInput(input, board);
            } catch (NumberFormatException nfe) {
                System.out.println(nfe.getMessage());
            }
        }
    }
}
