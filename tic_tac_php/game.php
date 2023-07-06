<?php

interface IGame {
    public function switchCurrentPlayer();
    public function display();
    public function isWinner(): bool;
    public function isDraw(): bool;
    public function isOver(): bool;
    public function makeMove();
}

class Game implements IGame {
    private Player $player1;
    private Player $player2;
    private ?Player $currentPlayer;
    private ?Player $winner;
    private Board $board;

    public function __construct(Player $p1, Player $p2) {
        $this->player1 = $p1;
        $this->player2 = $p2;
        $this->currentPlayer = $p1;
        $this->winner = null;
        $this->board = new Board();
    }

    public function __get($name) {
        return $this->$name;
    }

    public function switchCurrentPlayer() {
        if ($this->currentPlayer == $this->player1) {
            $this->currentPlayer = $this->player2;
        } elseif ($this->currentPlayer == $this->player2) {
            $this->currentPlayer = $this->player1;
        }
    }

    public function display() {
        $this->board->display();
    }

    public function isWinner(): bool {
        return $this->board->checkWinner();
    }

    public function isDraw(): bool {
        return $this->board->isFull();
    }

    public function isOver(): bool {
        if ($this->isWinner()) {
            $this->winner = $this->currentPlayer;
            $this->board->setRemainingCells();
            clearTerminal();
            $this->display();
            $winnerName = $this->winner->name;
            echo "Game over! $winnerName is the winner!\n";
            return true;
        }

        if ($this->isDraw()) {
            $this->winner = null;
            $this->currentPlayer = null;
            echo "Game over! It is a draw";
            return true;
        }

        return false;
    }

    public function makeMove() {
        while (true) {
            try {
                $input = getUserInput($this->currentPlayer->name);
                [$row, $col] = inputToCoords($input);

                $this->board->setCell($row, $col, $this->currentPlayer->mark);
                break;
            } catch (Exception $e) {
                echo $e->getMessage();
            }
        }
    }
}

?>