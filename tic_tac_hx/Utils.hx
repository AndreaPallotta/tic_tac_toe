import haxe.Exception;
import sys.io.Process;
import StringTools;

class Utils {
    public static var O:String = "O";
    public static var X:String = "X";
    public static var DEF:String = "-";

    public static function clearTerminal():Void {
        // Sys.print("\033\143");
    }

    public static function getUserName(playerNum:UInt):String {
        var defName = 'Player $playerNum';

        Sys.print('Insert player $playerNum name (default "$defName"): ');
        var input = StringTools.trim(Sys.stdin().readLine());

        return input == "" ? defName : input;
    }

    public static function getUserCoords(playerName:String): Array<Int> {
        Sys.print('Player $playerName, enter row and column (e.g. "1 2"): ');
        var input = StringTools.trim(Sys.stdin().readLine());
        var inputArr = input.split(" ");

        if (inputArr.length != 2) {
            throw new Exception("Invalid row or column. Try again");
        }

        try {
            var row = Std.parseInt(inputArr[0]);
            var col = Std.parseInt(inputArr[1]);

            if (row == null || col == null) throw new Exception("");

            return [row - 1, col - 1];
        } catch (_) {
            throw new Exception("Invalid row or column. Try again");
        }
    }

    public static function transpose(matrix:Array<Array<String>>): Array<Array<String>> {
        var transposedMatrix = [];
        
        for (row in 0...matrix.length) {
            var transposedRow = [];
            for (col in 0...matrix.length) {
                transposedRow.push(matrix[col][row]);
            }
            transposedMatrix.push(transposedRow);
        }

        return transposedMatrix;
    }
}

