export default class Player {
    constructor(name, mark) {
        this.name = name;
        this.mark = mark;
    }

    getName() {
        return this.name;
    }

    getMark() {
        return this.mark;
    }

    makeMove(board, row, col) {
        try {
            board.setCell(row, col, this.mark);
            return true;
        } catch (_) {
            return false;
        }
    }
};