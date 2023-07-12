import haxe.Exception;

class Game {
    private var _player1:Player;
    private var _player2:Player;
    private var _currentPlayer:Null<Player>;
    private var _winner:Null<Player>;
    private var _board:Board;

    public function new(player1:Player, player2:Player) {
        this._player1 = player1;
        this._player2 = player2;
        this._currentPlayer = player1;
        this._winner = null;
        this._board = new Board();
    }

    public function currentPlayer():Null<Player> {
        return this._currentPlayer;
    }

    public function switchCurrentPlayer():Void {
        if (this._currentPlayer == null) {
            throw new Exception("Cannot find current player");
        }

        if (this._currentPlayer == this._player1) {
            this._currentPlayer = this._player2;
        } else if (this._currentPlayer == this._player2) {
            this._currentPlayer = this._player1;
        }
    }

    public function display():Void {
        this._board.display();
    }

    public function isWinner():Bool {
        return this._board.checkWinner();
    }

    public function isDraw():Bool {
        return this._board.isFull();
    }

    public function isOver():Bool {
        if (this.isWinner()) {
            this._winner = this._currentPlayer;
            this._board.setRemainingCells();
            this.display();
            Sys.println('Game over. ${this._currentPlayer.name} is the winner!');
            return true;
        }

        if (this.isDraw()) {
            this._winner = null;
            this._currentPlayer = null;
            Sys.println("Game over! It is a draw!");
            return true;
        }

        return false;
    }

    public function makeMove():Void {
        if (this._currentPlayer == null) {
            throw new Exception("Current player not found");
        }

        while (true) {
            try {
                var coords = Utils.getUserCoords(this._currentPlayer.name());
                this._board.setCell(coords[0], coords[1], this._currentPlayer.mark());
                break;
            } catch (e:Exception) {
                Sys.println(e.message);
            }
        }
    }
}