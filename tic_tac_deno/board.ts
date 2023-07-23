import { Errors, Mark, print, transpose } from "./utils.ts"

export default class Board {
    SIZE = 3
    cells: string[][] = Array.from(Array(this.SIZE), () => Array(this.SIZE).fill('')) 

    isValidPosition(row: number, col: number, fullCheck = true): boolean {
        if (row < 0 || col < 0 || row >= this.SIZE || col >= this.SIZE) {
            return false
        }

        return !fullCheck || this.cells[row][col] == ''
    }

    getCell(row: number, col: number): string {
        if (!this.isValidPosition(row, col, false)) {
            throw new Error(Errors.ERR_INV_ROW_COL)
        }
        return this.cells[row][col]
    }

    setCell(row: number, col: number, mark: string): void {
        if (!this.isValidPosition(row, col)) {
            throw new Error(Errors.ERR_INV_ROW_COL)
        }
        this.cells[row][col] = mark
    }

    display(): void {
        console.log("\n     c1  c2  c3")
        console.log("   -------------")
        
        this.cells.forEach((row: string[], i: number) => {
            print(`r${i+1} |`)
            row.forEach((cell: string) => {
                print(`${cell.padStart(2)} |`)
            })
            console.log("\n   -------------")
        })
        console.log() 
    }

    isFull(): boolean {
        return !this.cells.every((row: string[]) => row.some((cell: string) => cell == ''))
    }

    hasHorizontalWin(): boolean {
        return this.cells.some((row: string[]) => [...new Set(row)].length == 1 && row[0] != '')
    }

    hasVerticalWin(): boolean {
        return transpose(this.cells).some((col: string[]) => [...new Set(col)].length == 1 && col[0] != '')
    }

    hasDiagonalWin(): boolean {
        const mainDiag = Array.from({ length: this.SIZE }, (_, i: number) => this.cells[i][i])
        const secDiag = Array.from({ length: this.SIZE }, (_, i: number) => this.cells[i][this.SIZE - i - 1])
        
        const mainMatch = [... new Set(mainDiag)].length == 1 && mainDiag[0] != ''
        const secMatch = [... new Set(secDiag)].length == 1 && secDiag[0] != ''

        return mainMatch || secMatch
    }

    checkWinner(): boolean {
        return this.hasHorizontalWin() || this.hasVerticalWin() || this.hasDiagonalWin()
    }

    setRemainingCells(): void {
        this.cells.forEach((row: string[], i: number) => {
            row.forEach((cell: string, j: number) => {
                if (cell == '') this.setCell(i, j, Mark.DEF)
            })
        })
    }
}