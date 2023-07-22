const std = @import("std");
const Utils = @import("utils.zig");
const Player = @import("player.zig").Player;
const Game = @import("game.zig").Game;

pub fn main() !void {
    const out = std.io.getStdOut().writer();
    try Utils.clearTerminal();
    try out.print("Welcome to Tic Tac Zig!\n\n", .{});

    var roundCounter = 1;
    
    const p1Name = try Utils.getUserName("1");
    const p2Name = try Utils.getUserName("2");
    const p1 = Player.init(p1Name, Utils.Mark.O);
    const p2 = Player.init(p2Name, Utils.Mark.X);

    const game = Game.init(p1, p2);
    game.display();

    while (true) {
        game.makeMove();

        roundCounter += 1;
        try Utils.clearTerminal();
        try out.print("Here's the updated board. Round {d}\n", .{roundCounter});

        game.display();

        if (game.isOver()) {
            break;
        }

        try game.switchCurrentPlayer();
        try out.print("It is now {s} turn!\n", .{game.currentPlayer.?.name});
    }
}