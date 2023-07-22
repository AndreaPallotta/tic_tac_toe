const std = @import("std");

pub const Mark = struct {
    pub const O: []const u8 = "O";
    pub const X: []const u8 = "X";
    pub const DEF: []const u8 = "-";
};

pub const Coords = struct {
    row: i8,
    col: i8,
};

pub fn clearTerminal() !void {
    const out = std.io.getStdOut().writer();
    try out.print("{s}", .{"\x1B[2J\x1B[H"});
}

pub fn getUserName(comptime playerNum: *const [1:0]u8) ![]const u8 {
    const out = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    const defName = "Player " ++ playerNum;

    var buf: [1024]u8 = undefined;

    try out.print("Insert player {s} name (default '{s}'): ", .{playerNum, defName});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        const trimmedInput = std.mem.trim(u8, input, " ");
        if (std.mem.eql(u8, trimmedInput, "")) {
            return defName;
        } else {
            return trimmedInput;
        }
    } else {
        return defName;
    }
}

pub fn getUserCoords(comptime userName: []const u8) !Coords {
    const out = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    var buf: [1024]u8 = undefined;

    try out.print("Player {s}, enter row and column (e.g. '1 2'): ", .{userName});

    if (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |input| {
        var iter = std.mem.split(u8, input, " ");

        var row = iter.first();
        var col = iter.next();

        if (col) |val| {
            return Coords {
                .row = try std.fmt.parseInt(i8, row, 0) - 1,
                .col = try std.fmt.parseInt(i8, val, 0) - 1,
            };
        } else {
            @panic( "Invalid row or column. Try again");
        }        
    } else {
       @panic("Invalid row or column. Try again");
    }
}