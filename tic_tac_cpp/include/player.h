#ifndef PLAYER_H
#define PLAYER_H

#include <string>
#include "utils.h"

class Player {
    private:
        std::string name;
        Mark mark;

    public:
        Player(const std::string& playerName, Mark playerMark);
        std::string getName() const;
        Mark getMark() const;
};


#endif