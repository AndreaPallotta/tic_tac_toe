import Board from "./board.js";
import { clearTerminal, parseInput } from "./utils.js";

export default class Game {
    constructor(player1, player2) {
        this.board = new Board();
        this.player1 = player1;
        this.player2 = player2;
        this.currentPlayer = player1;
        this.winner = null;
    }

    getCurrentPlayer() {
        return this.currentPlayer;
    }

    getBoard() {
        return this.board;
    }

    switchCurrentPlayer() {
        this.currentPlayer = this.currentPlayer === this.player1 ? this.player2 : this.player1;
    }

    display() {
        this.board.display();
    }

    isWinner() {
        return this.board.checkWinner();
    }

    isDraw() {
        return this.board.isFull();
    }

    isOver() {
        if (this.isDraw()) {
            this.winner = null;
            this.currentPlayer = null;
            return true;
        }

        if (this.isWinner()) {
            this.winner = this.currentPlayer;
            clearTerminal();
            this.board.setRemainingCells();
            this.display();
            return true;
        }

        return false;
    }

    announceWinner() {
        console.log(`${this.currentPlayer.getName()} is the winner!`);
    }

    announceDraw() {
        console.log("It is a draw!");
    }

    async getPlayerMove() {
        while (true) {
            try {
                return await parseInput(this.board, this.currentPlayer.getName());
            } catch (err) {
                console.log(err.message);
            }
        }
    }
};