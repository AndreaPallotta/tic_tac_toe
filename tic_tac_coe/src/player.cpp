#include "player.h"

Player::Player(const std::string& playerName, Mark playerMark)
    : name(playerName), mark(playerMark) {}

std::string Player::getName() const {
    return name;
}

Mark Player::getMark() const {
    return mark;
}
