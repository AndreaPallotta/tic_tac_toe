package tic_tac_kt

object Utils {
    class Mark {
        companion object {
            const val O = "O";
            const val X = "X";
            const val DEF = "-"
        }
    }

    fun clearTerminal() {
        print("\u001b[H\u001b[2J")
    }

    fun getUserName(playerNum: Int): String {
        var defName = "Player $playerNum"

        print("Insert Player $playerNum name (default '$defName'): ")
        val input = readLine()?.trim() ?: ""

        if (input.isEmpty()) {
            return defName;
        }
        
        return input;
    }

    fun getCoords(playerName: String): Pair<Int, Int> {
        print("Player $playerName, enter row and column (e.g. '1 2'): ")
        val input = readLine()?.trim() ?: ""
        val inputArr = input.split(" ")

        if (inputArr.size != 2) {
            throw Exception("Invalid row or column. Try again")
        }

        try {
            val row = inputArr.get(0).toInt()
            val col = inputArr.get(1).toInt()

            return Pair(row - 1, col - 1)
        } catch (_: Exception) {
            throw Exception("Invalid row or column. Try again")
        }
    }
}
