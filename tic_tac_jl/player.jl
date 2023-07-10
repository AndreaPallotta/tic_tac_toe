module PlayerMod

struct Player
    name::String
    mark::String

    function Player(name::String, mark::String)
        new(name, mark)
    end
end

end