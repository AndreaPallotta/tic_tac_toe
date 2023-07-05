#include "board.h"
#include "utils.h"

Board::Board() {
    cells.resize(SIZE, std::vector<std::string>(SIZE, "   "));
}

int Board::getSize() const {
    return SIZE;
}

std::vector<std::vector<std::string>> Board::getCells() const {
    return cells;
}

bool Board::isValidPosition(int row, int col) const {
    if (row < 0 || row >= SIZE || col < 0 || col >= SIZE) {
        return false;
    }

    std::string cell = cells[row][col];
    trim(cell);

    if (!cell.empty() && cell != "-") {
        
        return false;
    }

    return true;
}

std::string Board::getCell(int row, int col) const {
    if (!isValidPosition(row, col)) {
        throw std::out_of_range("Invalid row or column value");
    }
    return cells[row][col];
}

void Board::setCell(int row, int col, Mark mark) {
    if (!isValidPosition(row, col)) {
        throw std::out_of_range("Invalid row or column value. Try again");
    }

    std::string markStr = markToString(mark);

    cells[row][col] = " " + markStr + " ";
}

void Board::display() const {
    std::cout << std::endl;
    std::cout << "      c1  c2  c3" << std::endl;
    std::cout << "    -------------" << std::endl;

    for (int i = 0; i < SIZE; i++) {
        std::cout << "r" << i + 1 << " |";

        for (int j = 0; j < SIZE; j++) {
            std::cout << cells[i][j] << "|";
        }

        std::cout << std::endl;

        if (i < SIZE - 1) {
            std::cout << "    -------------" << std::endl;
        }
    }

    std::cout << std::endl;
    
}

bool Board::isFull() const {
    for (const auto& row : cells) {
        for (const std::string& cell : row) {
            std::string trimmedCell = cell;
            trim(trimmedCell);
            if (trimmedCell.empty() || trimmedCell == " - ") {
                return false;
            }
        }
    }

    return true;
}

bool Board::hasHorizontalWin() const {
    for (const std::vector<std::string>& row : cells) {
        std::vector<std::string> trimmedRow = row;
        for (std::string& cell : trimmedRow) {
            trim(cell);
        }
        if (trimmedRow[0] != "" && trimmedRow[0] == trimmedRow[1] && trimmedRow[0] == trimmedRow[2]) {
            return true;
        }
    }
    return false;
}

bool Board::hasVerticalWin() const {
    for (int i = 0; i < SIZE; i++) {
        std::vector<std::string> column;
        for (const auto& row : cells) {
            std::string cell = row[i];
            trim(cell);
            column.push_back(cell);
        }
        if (column[0] != "" && column[0] == column[1] && column[0] == column[2]) {
            return true;
        }
    }
    return false;
}

bool Board::hasDiagonalWin() const {
    auto diagonals = getMatrixDiags(cells);
    auto diagonal1 = std::get<0>(diagonals);
    auto diagonal2 = std::get<1>(diagonals);

    if (std::adjacent_find(diagonal1.begin(), diagonal1.end(), std::not_equal_to<>()) == diagonal1.end() && !diagonal1[0].empty()) {
        return true;
    }

    if (std::adjacent_find(diagonal2.begin(), diagonal2.end(), std::not_equal_to<>()) == diagonal2.end() && !diagonal2[0].empty()) {
        return true;
    }

    return false;
}

bool Board::checkWinner() const {
    return hasHorizontalWin() || hasVerticalWin() || hasDiagonalWin();
}

void Board::setRemainingCells() {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            if (cells[i][j].empty()) {
                cells[i][j] = " - ";
            }
        }
    }
}

std::tuple<int, int> Board::getMove(Player &player) {
    std::string input;
    std::vector<int> moveCoords;
    
    while (true) {
        std::cout << "Player '" << player.getName() << "', enter row and column (e.g. '1 2'): ";
        std::getline(std::cin, input);

        try {
            moveCoords = getCoordsFromInput(trim_c(input)); 
            break;
        } catch (const std::invalid_argument& e) {
            std::cout << e.what() << std::endl;
        }
    }

    return std::make_tuple(moveCoords[0], moveCoords[1]);
}
