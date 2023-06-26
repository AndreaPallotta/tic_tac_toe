import * as process from 'process';
import { allEquals, transpose } from './utils.js';

export default class Board {
    constructor(size = 3) {
        this.cells = Array.from({ length: size }, () => Array(size).fill("   "));
        this.size = size;
    }

    getSize() {
        return this.size;
    }

    getCells() {
        return this.cells;
    }

    isValidPosition(row, col) {
        if (row < 0 || row >= this.size || col < 0 || col > this.size) return false;
        if (this.cells[row][col].trim() !== "") return false;

        return true;
    }

    getCell(row, col) {
        if (!this.isValidPosition(row, col)) {
            throw new Error("Invalid row or column value");
        }

        return this.cells[row][col];
    }

    setCell(row, col, mark) {
        if (!this.isValidPosition(row, col)) {
            throw new Error("Invalid row or column value");
        }

        this.cells[row][col] = ` ${mark} `;
    }

    display() {
        console.log("      c1  c2  c3");
        console.log("    -------------");

        for (let i = 0; i < this.size; i++) {
            process.stdout.write(`r${i + 1}  |`);

            for (let j = 0; j < this.size; j++) {
                process.stdout.write(`${this.cells[i][j]}|`);
            }

            console.log();

            if (i < 2) {
                console.log("    -------------");
            }
        }

        console.log("    -------------");
    }

    isFull() {
        return this.cells.every((row) => row.every((cell) => cell.trim() !== "" && cell.trim() !== "-"));
    }

    hasHorizontalWin() {
        for (let row of this.cells) {
            if (allEquals(row)) return true;
        }
        return false;
    }

    hasVerticalWin() {
        for (let col of transpose(this.cells)) {
            if (allEquals(col)) return true;
        }
        return false;
    }

    hasDiagonalWin() {
        const topLeft = this.cells[0][0].trim();
        const topRight = this.cells[0][this.size - 1].trim();

        if (topLeft !== "" && this.cells.every((row, i) => row[i].trim() === topLeft)) {
            return true;
        }

        if (topRight !== "" && this.cells.every((row, i) => row[this.size - i - 1].trim() === topRight)) {
            return true;
        }
        return false;
    }

    checkWinner() {
        return this.hasHorizontalWin() || this.hasVerticalWin() || this.hasDiagonalWin();
    }

    setRemainingCells() {
        for (let i = 0; i < this.size; i++) {
            for (let j = 0; j < this.size; j++) {
                if (this.cells[i][j].trim() === "") {
                    this.cells[i][j] = " - ";
                }
            }
        }
    }
};