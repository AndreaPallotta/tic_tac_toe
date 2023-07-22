const std = @import("std");
const Utils = @import("utils.zig");

pub const Board = struct {
    size: usize = 3,
    cells: [3][3][]const u8 = undefined,

    pub fn init() Board {
        var matrix = [3][3][]const u8 {
            [_][]const u8{ "", "", "" },
            [_][]const u8{ "", "", "" },
            [_][]const u8{ "", "", "" },
        };

        return Board {
            .cells = matrix,
        };
    }

    pub fn isValidPosition(self: Board, row: usize, col: usize, fullCheck: bool) !bool {
        if (row < 0 or col < 0 or row >= self.size or col >= self.size) {
            return false;
        }

        return !fullCheck or std.mem.eql(u8, self.cells[row][col], Utils.emptyString);
    }

    pub fn getCell(self: Board, row: usize, col: usize) ![]u8 {
        if (!try self.isValidPosition(row, col, false)) {
            @panic("Invalid row or column value. Try again");
        }

        return self.cells[row][col];
    }

    pub fn setCell(self: Board, row: usize, col: usize, mark: []const u8) !void {
        if (!try self.isValidPosition(row, col, true)) {
            @panic("Invalid row or column value. Try again");
        }
        self.cells[row][col] = mark;
    }

    pub fn display(self: Board) !void {
        const out = std.io.getStdOut().writer();


        try out.print("\n     c1  c2  c3\n", .{});
        try out.print("   -------------\n", .{});

        for (0..self.size) |i| {
            try out.print("r{d} |", .{i + 1});
            for (0..self.size) |j| {
                if (std.mem.eql(u8, self.cells[i][j], Utils.emptyString)) {
                    try out.print("  {s} |", .{self.cells[i][j]});
                    
                } else {
                    try out.print(" {s} |", .{self.cells[i][j]});
                }
            }
            try out.print("\n   -------------\n", .{});
        }

        try out.print("\n", .{});
    }

    pub fn isFull(self: Board) bool {
        var full = true;
        for (self.cells) |row| {
            for (row) |cell| {
                if (std.mem.eql(u8, cell, "")) {
                    full = false;
                    break;
                }
            }
            if (!full) {
                break;
            }
        }
        return full;
    }

    pub fn hasHorizontalWin(self: Board) bool {
        for (0..self.size) |i| {
            var allEqual = true;
            const firstEl = self.cells[i][0];
            for (self.cells[i]) |cell| {
                if (!std.mem.eql(u8, cell, firstEl) or std.mem.eql(u8, cell, "")) {
                    allEqual = false;
                    break;
                }
            }

            if (allEqual) {
                return true;
            }
        }

        return false;
    }

    pub fn hasVerticalWin(self: Board) bool {
        var columns: [self.size][][]const u8 = undefined;

        for (0..self.size) |i| {
             for (0..self.size) |j| {
                columns[j][i] = self.cells[i][j];
             }
        }

        for (columns) |col| {
            var allEqual = true;
            const firstEl = col[0];
            for (col) |cell| {
                if (!std.mem.eql(u8, cell, firstEl) or std.mem.eql(u8, cell, "")) {
                    allEqual = false;
                    break;
                }
            }

            if (allEqual) {
                return true;
            }
        }
        return false;
    }

    pub fn hasDiagonalWin(self: Board) bool {
        const mainDiag: [self.size][]const u8 = undefined;
        const secDiag: [self.size][]const u8 = undefined;

        for (0..self.size) |i| {
            mainDiag[i] = self.cells[i][i];
            secDiag[i] = self.cells[i][self.size - i - 1];
        }

        var mainMatch: bool = !std.mem.eql(u8, mainDiag[0], "");

        if (mainMatch) {
            for (mainDiag) |cell| {
                if (std.mem.eql(u8, cell, mainDiag[0])) {
                    mainMatch = true;
                    break;
                }
            }
        }

        var secMatch: bool = !std.mem.eql(u8, secDiag[0], "");
        if (secMatch) {
            for (secDiag) |cell| {
                if (std.mem.eql(u8, cell, secDiag[0])) {
                    secMatch = true;
                    break;
                }
            }
        }

        return mainMatch or secMatch;
    }

    pub fn checkWinner(self: Board) bool {
        return self.hasHorizontalWin() or self.hasVerticalWin() or self.hasDiagonalWin();
    }

    pub fn setRemainingCells(self: Board) void {
        for (0..self.size) |i| {
            for (0..self.size) |j| {
                if (std.mem.eql(u8, self.cells[i][j], "")) {
                    self.cells[i][j] = Utils.Mark.DEF;
                }
            }
        }
    }
};