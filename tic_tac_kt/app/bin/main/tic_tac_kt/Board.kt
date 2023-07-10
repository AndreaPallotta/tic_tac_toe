package tic_tac_kt

inline fun <reified T>Array<Array<T>>.transpose(): Array<Array<T>> {
    return Array(this[0].size) { i -> Array(this.size) { j -> this[j][i] } }
}

class Board {
    companion object {
        const val SIZE = 3
    }

    private var cells: Array<Array<String>> = Array(3) { Array(3) { "" } }

    public fun isValidPosition(row: Int, col: Int, fullCheck: Boolean = true): Boolean {
        if (row < 0 || col < 0 || row >= SIZE || col >= SIZE) {
            return false
        }

        if (fullCheck) {
            return cells.get(row).get(col).isEmpty()
        }

        return true
    }

    public fun getCell(row: Int, col: Int): String {
        if (!isValidPosition(row, col)) {
            throw Exception("Invalid row or column value. Try again")
        }

        return cells.get(row).get(col)
    }

    public fun setCell(row: Int, col: Int, mark: String) {
        if (!isValidPosition(row, col)) {
            throw Exception("Invalid row or column value. Try again")
        }

        cells[row][col] = mark
    }

    public fun display() {
        println("\n     c1  c2  c3")
        println("   -------------")

        cells.forEachIndexed { i, row ->
            print("r${i+1} |")
            row.forEach { cell ->
                print(String.format(" %1s |", cell))
            }

            println("\n   -------------")
        }

        println("")
    }

    public fun isFull(): Boolean {
        return !cells.any { row -> row.any { cell -> cell.isEmpty() } }
    }

    public fun hasHorizontalWin(): Boolean {
        return cells.any { row -> row.distinct().size == 1 && !row.getOrElse(0) { "" }.isEmpty() }
    }

    public fun hasVerticalWin(): Boolean {
        return cells.transpose().any { col -> col.distinct().size == 1 && !col.getOrElse(0) { "" }.isEmpty() }
    }

    public fun hasDiagonalWin(): Boolean {
        val mainDiag = List(SIZE) { i -> cells[i][i] }
        val secDiag = List(SIZE) { i -> cells[i][SIZE - i - 1] }

        val mainMatch = mainDiag.distinct().size == 1 && !mainDiag.getOrElse(0) { "" }.isEmpty()
        val secMatch = secDiag.distinct().size == 1 && !secDiag.getOrElse(0) { "" }.isEmpty()

        return mainMatch || secMatch
    }

    public fun checkWinner(): Boolean {
        return hasHorizontalWin() || hasVerticalWin() || hasDiagonalWin()
    }
    
    public fun setRemainingCells() {
        cells.forEachIndexed { i, row ->
            row.forEachIndexed { j, cell ->
                if (cell.isEmpty()) {
                    setCell(i, j, Utils.Mark.DEF)
                }
            }
        }
    }
}