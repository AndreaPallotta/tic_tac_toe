import Board from "./board.ts";
import Player from "./player.ts";
import { Errors, clearTerminal, getUserCoords } from "./utils.ts";

export default class Game {
    player1: Player
    player2: Player
    currentPlayer: Player | null
    winner: Player | null
    board: Board

    constructor(player1: Player, player2: Player) {
        this.player1 = player1
        this.player2 = player2
        this.currentPlayer = player1
        this.winner = null
        this.board = new Board()
    }

    switchCurrentPlayer(): void {
        if (!this.currentPlayer) {
            throw new Error(Errors.ERR_NO_CURR_PLAYER)
        }

        if (this.currentPlayer == this.player1) {
            this.currentPlayer = this.player2
        } else if (this.currentPlayer == this.player2) {
            this.currentPlayer = this.player1
        }
    }

    display(): void {
        this.board.display()
    }

    isWinner(): boolean {
        return this.board.checkWinner()
    }

    isDraw(): boolean {
        return this.board.isFull()
    }

    isOver(): boolean {
        if (this.isWinner()) {
            this.winner = this.currentPlayer
            this.board.setRemainingCells()
            clearTerminal()
            this.display()
            console.log(`Game over! ${this.currentPlayer?.name} is the winner!`)
            return true
        }
        if (this.isDraw()) {
            this.winner = null
            this.currentPlayer = null
            console.log("Game over! It is a draw!")
            return true
        }
        return false
    }

    makeMove(): void {
        if (!this.currentPlayer) {
            throw new Error(Errors.ERR_NO_CURR_PLAYER)
        }

        while (true) {
            try {
                const [row, col] = getUserCoords(this.currentPlayer.name)
                this.board.setCell(row, col, this.currentPlayer.mark)
                break
            } catch (e: unknown) {
                console.log((e as Error).message)
            }
        }
    }
}