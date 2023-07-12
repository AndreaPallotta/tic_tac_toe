import haxe.Exception;

class Board {
    public static var SIZE = 3;
    private var _cells:Array<Array<String>> = [for (_ in 0...SIZE) [for (_ in 0...SIZE) ""]];

    public function new() {};

    public function isValidPositon(row:Int, col:Int, fullCheck = true):Bool {
        if (row < 0 || col < 0 || row > SIZE || col > SIZE) {
            return false;
        }

        return !fullCheck || this._cells[row][col] == "";
    }

    public function getCell(row:Int, col:Int):String {
        if (!isValidPositon(row, col, false)) {
            throw new Exception("Invalid row or column value. Try again");
        }

        return this._cells[row][col];
    }

    public function setCell(row:Int, col:Int, mark:String):Void {
        if (!isValidPositon(row, col)) {
            throw new Exception("Invalid row or column value. Try again");
        }

        this._cells[row][col] = mark;
    }

    public function display():Void {
        Sys.println("\n     c1  c2  c3");
        Sys.println("    ------------");

        for (i in 0...SIZE) {
            Sys.print('r${i+1} |');
            for (j in 0...SIZE) {
                Sys.print('${StringTools.lpad(this._cells[i][j], " ", 2)} |');
            }
            Sys.println("\n   -------------");
        }
        Sys.println("");
    }

    public function isFull():Bool {
        for (row in this._cells) {
            for (cell in row) {
                if (cell == "") {
                    return false;
                }
            }   
        }

        return true;
    }

    public function hasHorizontalWin():Bool {
         for (row in this._cells) {
            var distinctElements = new Map<String, Bool>();
            for (element in row) {
                distinctElements.set(element, true);
            }
            var count = 0;
            for (_ in distinctElements.keys()) {
                count++;
            }
            if (count == 1 && !distinctElements.exists("")) {
                return true;
            }
        }
        return false;
    }

    public function hasVerticalWin():Bool {
        for (col in Utils.transpose(this._cells)) {
            var distinctElements = new Map<String, Bool>();
            for (element in col) {
                distinctElements.set(element, true);
            }
            var count = 0;
            for (_ in distinctElements.keys()) {
                count++;
            }
            if (count == 1 && !distinctElements.exists("")) {
                return true;
            }
        }
        return false;
    }

    public function hasDiagonalWin():Bool {
        var firstElement = this._cells[0][0];
        var allEqual = true;
        for (i in 0...SIZE) {
            if (this._cells[i][i] != firstElement) {
                allEqual = false;
                break;
            }
        }

        if (allEqual && firstElement != "") {
            return true;
        }

        firstElement = this._cells[0][SIZE - 1];
        allEqual = true;
        
        for (i in 0...SIZE) {
            if (this._cells[i][SIZE - i - 1] != firstElement) {
                allEqual = false;
                break;
            }
        }

        if (allEqual && firstElement != "") {
            return true;
        }
        return false;
    }

    public function checkWinner():Bool {
        return this.hasHorizontalWin() || this.hasVerticalWin() || this.hasDiagonalWin();
    }

    public function setRemainingCells():Void {
        for (i in 0...SIZE) {
            for (j in 0...SIZE) {
                if (this._cells[i][j] == "") {
                    this.setCell(i, j, Utils.DEF);
                }
            }
        }
    }
}