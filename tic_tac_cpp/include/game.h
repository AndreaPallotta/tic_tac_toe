#ifndef GAME_H
#define GAME_H

#include <iostream>
#include "board.h"
#include "player.h"

class Game {
    private:
        Board board;
        Player player1;
        Player player2;
        Player* currentPlayer;
        Player* winner;

    public:
        Game(const Player& player1, const Player& player2);
        Player* getCurrentPlayer() const;
        const Board& getBoard() const;
        std::string getCurrPlayerName() const;
        void switchCurrentPlayer();
        void display() const;
        bool isWinner() const;
        bool isDraw() const;
        bool isOver();
        void announceDraw() const;
        void announceWinner() const;
        void makeMove(int row, int col);
};

#endif