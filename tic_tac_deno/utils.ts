import * as mod from "https://deno.land/std@0.195.0/streams/write_all.ts";

export enum Mark {
    O = 'O',
    X = 'X',
    DEF = '-',
}

export function print(msg: string) {
    mod.writeAllSync(Deno.stdout, new TextEncoder().encode(msg))
}

export const Errors = {
    ERR_INV_ROW_COL: "Invalid row or column. Try again.",
    ERR_NO_CURR_PLAYER: "Current player not found. Aborting game...",
    ERR_GENERIC: (err: string): string => {
        return `An error has been found: ${err}`;
    }
}

export function clearTerminal(): void {
    console.clear()
}

export function getUserName(playerNum: number): string {
    const defName = `Player ${playerNum}`
    const input = (prompt(`Insert player ${playerNum} name (default '${defName}'):`) ?? '').trim()
    return input || defName
}

export function getUserCoords(playerName: string): [number, number] {
    const input = (prompt(`Player ${playerName}, enter row and column (e.g. '1 2'):`) ?? '').trim()
    const [row, col] = input.split(' ').map((el) => Number.parseInt(el, 10))

    if (isNaN(row) || isNaN(col)) {
        throw new Error(Errors.ERR_INV_ROW_COL)
    }
    return [row - 1, col - 1]
}

export function transpose(matrix: string[][]): string[][] {
    return matrix[0].map((_: string, i: number) => matrix.map((row: string[]) => row[i]));
}
