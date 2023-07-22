class Board {

    private final int SIZE = 3
    private List<List<String>> cells;

    Board() {
        this.cells = (1..this.SIZE).collect { (1..this.SIZE).collect { '' }}
    }

    boolean isValidPosition(int row, int col, boolean fullCheck = true) {
        if (row < 0 || col < 0 || row >= this.SIZE || col >= this.SIZE) {
            return false
        }

        return !fullCheck || this.cells[row][col].isEmpty()
    }

    String getCell(int row, int col) {
        if (!this.isValidPosition(row, col, false)) {
            throw new Exception(Errors.ERR_INV_ROW_COL)
        }

        return this.cells[row][col]
    }

    void setCell(int row, int col, String mark) {
        if (!this.isValidPosition(row, col)) {
            throw new Exception(Errors.ERR_INV_ROW_COL)
        }

        this.cells[row][col] = mark
    }

    void display() {
        println('\n     c1  c2  c3')
        println('   -------------')

        for (i in 0..<this.SIZE) {
            print("r${i + 1} |")
            for (j in 0..<this.SIZE) {
                print(String.format("%2s |", this.getCell(i, j)))
            }

            println('\n   -------------')
        }

        println('')
    }

    boolean isFull() {
        return !this.cells.any { row -> row.any { it.isEmpty() }}
    }

    boolean hasHorizontalWin() {
        return this.cells.any { row -> row.unique().size() == 1 && !row[0].isEmpty() }
    }

    boolean hasVerticalWin() {
        return this.cells.transpose().any { col -> col.unique().size() == 1 && !col[0].isEmpty() }
    }

    boolean hasDiagonalWin() {
        List<String> mainDiag = this.cells.withIndex().collect { row, i -> row[i] }
        List<String> secDiag = this.cells.withIndex().collect { row, i -> row[this.SIZE - i - 1] }

        boolean mainMatch = mainDiag.unique().size() == 1 && !mainDiag[0].isEmpty()
        boolean secMatch = secDiag.unique().size() == 1 && !secDiag[0].isEmpty()

        return mainMatch || secMatch
    }

    boolean checkWinner() {
        return this.hasHorizontalWin() || this.hasVerticalWin() || this.hasDiagonalWin()
    }

    void setRemainingCells() {
        this.cells.eachWithIndex { row, i ->
            row.eachWithIndex { cell, j -> 
                if (cell.isEmpty()) {
                    this.setCell(i, j, Mark.DEF)
                }
            }
        }
    }
}
