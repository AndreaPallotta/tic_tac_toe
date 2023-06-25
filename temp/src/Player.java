public class Player {

    private final String name;
    private final Mark mark;

    public Player(String name, Mark mark) {
        this.name = name;
        this.mark = mark;
    }

    public String getName() {
        return this.name;
    }

    public Mark getMark() {
        return this.mark;
    }

    public boolean makeMove(Board board, int row, int col)  {
        try {
            board.setCell(row, col, this.mark);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
