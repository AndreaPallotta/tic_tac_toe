#include "utils.h"

std::string markToString(Mark mark) {
    switch (mark) {
        case Mark::X:
            return "X";
        case Mark::O:
            return "O";
    }
    return "";
}

void clearTerminal() {
    std::cout << "\x1B[2J\x1B[H";
}

void ltrim(std::string &input) {
    input.erase(input.begin(), std::find_if(input.begin(), input.end(), [](unsigned char ch) {
        return !std::isspace(ch);
    }));
}

void rtrim(std::string &input) {
    input.erase(std::find_if(input.rbegin(), input.rend(), [](unsigned char ch) {
        return !std::isspace(ch);
    }).base(), input.end());
}

void trim(std::string &input) {
    ltrim(input);
    rtrim(input);
}

std::string ltrim_c(std::string &input) {
    ltrim(input);
    return input;
}

std::string rtrim_c(std::string &input) {
    rtrim(input);
    return input;
}

std::string trim_c(std::string &input) {
    trim(input);
    return input;
}

std::vector<int> getCoordsFromInput(const std::string &input) {
    std::istringstream iss(input);
    std::vector<int> coords;
    std::string token;

    while (iss >> token) {
        int num;
        std::istringstream numStream(token);
        
        if (numStream >> num) {
            coords.push_back(num - 1);
        } else {
            std::invalid_argument("Invalid input " + token + ". Please enter valid row and column.");
        }
    }

    if (coords.size() != 2) {
        std::invalid_argument("Invalid input. Please enter valid row and column.");
    }

    return coords;
}

std::string getPlayerName(int playerNumber) {
    std::string input;
    std::string defName = "Player " + std::to_string(playerNumber);
    std::cout << "Insert Player " << playerNumber << " name (default '" << defName << "'): ";
    
    std::getline(std::cin, input);

    if ((trim_c(input)).empty()) {
        input = defName;
    }

    return input;
}

bool allEquals(std::vector<std::string>& row) {
    std::vector<std::string> uniqueRow = row;
    std::sort(uniqueRow.begin(), uniqueRow.end());
    auto last = std::unique(uniqueRow.begin(), uniqueRow.end());
    bool allSame = (last == uniqueRow.end()) && (uniqueRow.size() > 1);
    return allSame;
}

std::tuple<std::vector<std::string>, std::vector<std::string>> getMatrixDiags(const std::vector<std::vector<std::string>>& matrix) {
    std::vector<std::string> diag1;
    std::vector<std::string> diag2;

    for (int i = 0; i < matrix.size(); i++) {
        std::string firstDiagEl = matrix[i][i];
        std::string secondDiagEl = matrix[i][matrix.size() - i - 1];
        diag1.push_back(trim_c(firstDiagEl));
        diag2.push_back(trim_c(secondDiagEl));
    }

    return std::make_tuple(diag1, diag2);
}