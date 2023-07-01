#ifndef BOARD_H
#define BOARD_H

#include <iostream>
#include <vector>
#include <string>
#include <tuple>

#include "utils.h"
#include "player.h"

class Board {
    private:
        std::vector<std::vector<std::string>> cells;
        const int SIZE = 3;

    public:
        Board();
        int getSize() const;
        std::vector<std::vector<std::string>> getCells() const;
        bool isValidPosition(int row, int col) const;
        std::string getCell(int row, int col) const;
        void setCell(int row, int col, Mark mark);
        void display() const;
        bool isFull() const;
        bool hasHorizontalWin() const;
        bool hasVerticalWin() const;
        bool hasDiagonalWin() const;
        bool checkWinner() const;
        void setRemainingCells();
        std::tuple<int, int> getMove(Player &player);
};

#endif