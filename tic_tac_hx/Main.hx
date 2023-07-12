import haxe.Exception;

class Main {
    static public function main() {
        Utils.clearTerminal();
        Sys.println("Welcome to Tic Tac Hx!\n");
        
        try {
            var roundCounter = 1;

            var p1Name:String = Utils.getUserName(1);
            var p2Name:String = Utils.getUserName(2);

            var p1:Player = new Player(p1Name, Utils.O);
            var p2:Player = new Player(p2Name, Utils.X);

            Sys.println("");

            var game:Game = new Game(p1, p2);
            game.display();

            while (true) {
                game.makeMove();

                roundCounter++;
                Utils.clearTerminal();
                Sys.println('Here is the updated board. Round $roundCounter');

                game.display();

                if (game.isOver()) {
                    break;
                }

                game.switchCurrentPlayer();
                
                Sys.println('It is now ${game.currentPlayer().name()} turn!');
            }
            
        } catch (e:Exception) {
            Sys.println('An error has been found: ${e.message}');
        }
    }
}