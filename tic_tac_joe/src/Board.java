import java.util.Arrays;

public class Board {
    private String[][] cells;
    private final int SIZE = 3;

    public Board() {
        this.cells = new String[SIZE][SIZE];
        for (String[] row : cells) {
            Arrays.fill(row, "   ");
        }
    }
    
    public int getSize() {
        return this.SIZE;
    }

    public String[][] getCells() {
        return this.cells;
    }

    public boolean isValidPosition(int row, int col) {
        if (row < 0 || row >= this.SIZE || col < 0 || col >= this.SIZE) {
            return false;
        }

        if (!this.cells[row][col].trim().equals("")) {
            return false;
        }

        return true;
    }

    public String getCell(int row, int col) {
        if (!this.isValidPosition(row, col)) {
            throw new IllegalArgumentException("Invalid row or column value");
        }

        return this.cells[row][col];
    }

    public void setCell(int row, int col, Mark mark) {
        if (!this.isValidPosition(row, col)) {
            throw new IllegalArgumentException("Invalid row or column value. Try again");
        }

        this.cells[row][col] = " " + mark.toString() + " ";
    }

    public void display() {
        System.out.println("      c1  c2  c3");
        System.out.println("    -------------");

        for (int i = 0; i < this.cells.length; i++) {
            System.out.printf("r%d  |", i + 1);

            for (int j = 0; j < this.cells[i].length; j++) {
                System.out.print(this.cells[i][j]);
                System.out.print("|");
            }

            System.out.println();

            if (i < 2) {
                System.out.println("    -------------");
            }
            System.out.println("    -------------");
        }
    }

    public boolean isFull() {
        for (String[] row : this.cells) {
            for (String cell : row) {
                if (cell.trim().isEmpty() || cell.trim().equals("-")) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean hasHorizontalWin() {
        for (int i = 0; i < this.cells.length; i++) {
            if (Utils.allEquals(this.cells[i])) {
                return true;
            }
        }
        return false;
    }

    private boolean hasVerticalWin() {
        for (int i = 0; i < this.cells.length; i++) {
            String[] col = Utils.getMatrixCol(this.cells, i, 0);
            if (Utils.allEquals(col)) {
                return true;
            }
        }

        return false;
    }

    private boolean hasDiagonalWin() {
        String[][] diagonals = Utils.getMatrixDiags(this.cells);
        return Utils.allEquals(diagonals[0]) || Utils.allEquals(diagonals[1]);
    }

    public boolean checkWinner() {
        return this.hasHorizontalWin() || this.hasVerticalWin() || this.hasDiagonalWin();
    }

    public void setRemainingCells() {
        for (int i = 0; i < this.cells.length; i++) {
            for (int j = 0; j < this.cells[i].length; j++) {
                if (this.cells[i][j].trim().equals("")) {
        	        this.cells[i][j] = " - ";        
                }
            }
        }
    }
}
