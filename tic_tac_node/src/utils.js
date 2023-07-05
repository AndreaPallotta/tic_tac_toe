import inquirer from 'inquirer';
import * as process from 'process';

export const Mark = {
    O: 'O',
    X: 'X'
};

export const allEquals = (arr) => {
    const arrSet = new Set(arr.map((str) => str.trim()));

    return arrSet.size === 1 && arr[0].trim() !== "";
};

export const clearTerminal = () => {
    process.stdout.write("\u001b[2J\u001b[0;0H");
    console.clear();
};

export const parseInput = async (board, name) => {
    const questions = [
        {
            type: 'input',
            name: 'input',
            message: `Player ${name}, enter row and column separated by a space (e.g. '1 2'):`,
        }
    ];

    const { input } = await inquirer.prompt(questions);
    const fields = input.trim().split(' ');

    if (fields.length !== 2) {
        throw new Error('Invalid Input. Please enter row and column separated by a space.'); 
    }

    const row = parseInt(fields[0]);
    const col = parseInt(fields[1]);

    if (isNaN(row) || isNaN(col)) {
        throw new Error('Invalid input. Please enter valid row and column.');
    }

    if (!board.isValidPosition(row - 1, col - 1)) {
        throw new Error('Invalid input. Please enter valid row and column.');
    }

    return [row - 1, col - 1];
};

export const getPlayerName = async (defaultName, playerNumber) => {
    const questions = [
        {
            type: 'input',
            name: 'input',
            message: `Insert Player ${playerNumber} name (default '${defaultName}'):`,
        }
    ];

    const { input } = await inquirer.prompt(questions);
    const name = input.trim();

    return name !== "" ? name : defaultName;
};

export const transpose = (matrix) => {
    return matrix[0].map((_, colIndex) => matrix.map((row) => row[colIndex]));
};