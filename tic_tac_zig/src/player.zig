pub const Player = struct {
    name: []const u8,
    mark: []const u8,

    pub fn init(name: []const u8, mark: []const u8) Player {
        return Player {
            .name = name,
            .mark = mark,
        };
    }
};