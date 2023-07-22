const std = @import("std");
const Utils = @import("utils.zig");
const Player = @import("player.zig").Player;
const Board = @import("board.zig").Board;

pub const Game = struct {
    player1: Player,
    player2: Player,
    currentPlayer: ?Player,
    winner: ?Player,
    board: Board,

    pub fn init(p1: Player, p2: Player) Game {
        return Game {
            .player1 = p1,
            .player2 = p2,
            .currentPlayer = p1,
            .winner = null,
            .board = Board.init(),
        };
    }

    pub fn switchCurrentPlayer(self: Game) !void {
        if (self.currentPlayer == null) {
            @panic("Cannot find current player");
        }

        if (self.currentPlayer.? == self.player1) {
            self.currentPlayer = self.player2;
        } else if (self.currentPlayer.? == self.player2) {
            self.currentPlayer = self.player1;
        }
    }

    pub fn display(self: Game) void {
        self.board.display();
    }

    pub fn isWinner(self: Game) bool {
        return self.board.checkWinner();
    }

    pub fn isDraw(self: Game) bool {
        return self.board.isFull();
    }

    pub fn isOver(self: Game) bool {
        const out = std.io.getStdOut().writer();
        if (self.isWinner()) {
            self.winner = self.currentPlayer.?;
            self.board.setRemainingCells();
            Utils.clearTerminal();
            self.display();
            try out.print("Game over! ${s} is the winner!\n", .{self.currentPlayer.?.name});
            return true;
        }

        if (self.isDraw()) {
            self.winner = null;
            self.currentPlayer = null;
            try out.print("Game over! It is a draw!\n", .{});
            return true;
        }

        return false;
    }

    pub fn makeMove(self: Game) void {
        const out = std.io.getStdOut().writer();

        if (self.currentPlayer == null) {
            @panic("Cannot find current player");
        }

        while (true) {
            const coords: Utils.Coords = try Utils.getUserCoords(self.currentPlayer.?.name);
            
            if (try self.board.setCell(coords.row, coords.col, self.currentPlayer.?.mark)) |res| {
                if (res == true) {
                    break;
                }
            } else {
                try out.print("Error while making move.", .{});
            }
        }
    }
};