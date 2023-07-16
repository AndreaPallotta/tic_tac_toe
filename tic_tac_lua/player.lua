Player = {}

function Player.init(name, mark)
    local self = setmetatable({}, Player)
    self.name = name
    self.mark = mark
    return self
end

function Player.__eq(player1, player2)
    return player1.name == player2.name and player1.mark == player2.mark
end

return Player