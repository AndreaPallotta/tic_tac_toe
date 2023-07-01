#ifndef UTILS_H
#define UTILS_H

#include <string>
#include <iostream>
#include <sstream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <tuple>

enum class Mark { X, O };

std::string markToString(Mark mark);
void clearTerminal();
void ltrim(std::string &input);
void rtrim(std::string &input);
void trim(std::string &input);
std::string ltrim_c(std::string &input);
std::string rtrim_c(std::string &input);
std::string trim_c(std::string &input);
std::vector<int> getCoordsFromInput(const std::string& input);
std::string getPlayerName(int playerNumber);
bool allEquals(std::vector<std::string>& row);
std::tuple<std::vector<std::string>, std::vector<std::string>> getMatrixDiags(const std::vector<std::vector<std::string>>& board);

#endif