class Utils {

    static void clearTerminal() {
        print('\033\143')
    }

    static String getUserName(int playerNum) {
        String defName = "Player ${playerNum}"
        String input = System.console().readLine "Insert player ${playerNum} name (default '${defName}'): "
        return input.trim() ?: defName
    }

    static Tuple2<Integer, Integer> getUserCoords(String playerName) {
        String input = System.console().readLine "Player ${playerName}, enter row and column (e.g. '1 2'): "

        String[] inputArr = input.split(' ')

        if (inputArr.length != 2) {
            throw new Exception(Errors.ERR_INV_ROW_COL)
        }

        try {
            return new Tuple2(inputArr[0] as Integer - 1, inputArr[1] as Integer - 1)
        } catch (Exception e) {
            throw new Exception(Errors.ERR_INV_ROW_COL)
        }
    }

}
