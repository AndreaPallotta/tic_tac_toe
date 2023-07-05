#include "game.h"

Game::Game(const Player& player1, const Player& player2)
    : player1(player1), player2(player2), currentPlayer(&this->player1), winner(nullptr) {}

Player* Game::getCurrentPlayer() const {
    return currentPlayer;
}

const Board& Game::getBoard() const {
    return board;
}

std::string Game::getCurrPlayerName() const {
    return getCurrentPlayer()->getName();
}

void Game::switchCurrentPlayer() {
    currentPlayer = (currentPlayer == &player1) ? &player2 : &player1;
}

void Game::display() const {
    board.display();
}

bool Game::isWinner() const {
    return board.checkWinner();
}

bool Game::isDraw() const {
    return board.isFull();
}

bool Game::isOver() {
    if (isDraw()) {
        winner = nullptr;
        currentPlayer = nullptr;
        return true;
    }

    if (isWinner()) {
        winner = currentPlayer;
        clearTerminal();
        board.setRemainingCells();
        display();
        return true;
    }

    return false;
}

void Game::announceDraw() const {
    std::cout << "It's a draw!" << std::endl;
}

void Game::announceWinner() const {
    std::cout << winner->getName() << " is the winner!" << std::endl;
}

void Game::makeMove(int row, int col) {
    board.setCell(row, col, getCurrentPlayer()->getMark());
}