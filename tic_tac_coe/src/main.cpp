#include "game.h"
#include "utils.h"


int main() {
    clearTerminal();
    std::cout << "Welcome to Tic Tac Coe!" << std::endl;

    try {
        int roundCounter = 1;

        std::string p1Name = getPlayerName(1);
        std::string p2Name = getPlayerName(2);

        Player p1(p1Name, Mark::O);
        Player p2(p2Name, Mark::X);

        Game game(p1, p2);

        game.display();

        while (!game.isOver()) {
            Player* currentPlayer = game.getCurrentPlayer();
            Board board = game.getBoard();
            std::tuple<int, int> move = board.getMove(*currentPlayer);

            int row = std::get<0>(move);
            int col = std::get<1>(move);

            game.makeMove(row, col);

            roundCounter++;
            clearTerminal();
            std::cout << "Here's the updated board. Round " << roundCounter << std::endl << std::endl;

            game.display();

            if (game.isOver()) {
                break;
            }

            game.switchCurrentPlayer();
            std::cout << "It is now " << game.getCurrPlayerName() << " turn!" << std::endl;
        }

        std::cout << "Game over!" << std::endl;

        if (game.isDraw()) {
            game.announceDraw();
        } else {
            game.announceWinner();
        }

    } catch (std::exception& e) {
        std::cout << e.what() << std::endl;
    }

    return 0;
}
