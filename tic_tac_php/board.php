<?php
interface IBoard {
    public function isValidPosition(int $row, int $col): bool;
    public function getCell(int $row, int $col): string;
    public function setCell(int $row, int $col, string $mark);
    public function display();
    public function isFull(): bool;
    public function hasHorizontalWin(): bool;
    public function hasVerticalWin(): bool;
    public function hasDiagonalWin(): bool;
    public function checkWinner(): bool;
    public function setRemainingCells();
}

class Board implements IBoard {
    const SIZE = 3;
    private $cells;

    public function __construct() {
        $this->cells = array_fill(0, self::SIZE, array_fill(0, self::SIZE, ''));
    }

    public function __get($name) {
        return $this->$name;
    }

    public function isValidPosition(int $row, int $col, bool $fullCheck = true): bool {
        if ($row < 0 || $col < 0 || $row >= self::SIZE || $col >= self::SIZE) {
            return false;
        }

        $cell = $this->cells[$row][$col];

        return $fullCheck ? empty($cell) : true;
    }

    public function getCell(int $row, int $col): string {
        if (!$this->isValidPosition($row, $col, false)) {
            throw new Exception("Invalid row or column value. Try again");
        }

        return $this->cells[$row][$col];
    }

    public function setCell(int $row, int $col, string $mark) {
        if (!$this->isValidPosition($row, $col)) {
            throw new Exception("Invalid row or column value. Try again");
        }

        $this->cells[$row][$col] = $mark;
    }

    public function display() {
        echo "\n     c1  c2  c3\n";
        echo "    ------------\n";
        
        foreach ($this->cells as $i => $row) {
            echo "r" . ($i + 1) . " |";
            foreach ($row as $j => $cell) {
                echo sprintf(" %1s |", $cell);
            }

            echo "\n   -------------\n";
        }

        print_nline(1);
    }

    public function isFull(): bool {
        foreach ($this->cells as $row) {
            if (in_array('', $row)) {
                return false;
            }
        }

        return true;
    }

    public function hasHorizontalWin(): bool {
        foreach ($this->cells as $row) {
            if (!in_array('', $row) && count(array_unique($row)) === 1) {
                return true;
            }
        }

        return false;
    }

    public function hasVerticalWin(): bool {
        foreach (array_map(null, ...$this->cells) as $col) {
            if (!in_array('', $col) && count(array_unique($col)) === 1) {
                return true;
            }
        }
        return false;
    }

    public function hasDiagonalWin(): bool {
        $mainDiagonal = [];
        $secDiagonal = [];

        for ($i = 0; $i < self::SIZE; $i++) {
            $mainDiagonal[] = $this->getCell($i, $i);
            $secDiagonal[] = $this->getCell($i, self::SIZE - $i - 1);
        }

        $main_match = !in_array('', $mainDiagonal) && count(array_unique($mainDiagonal)) === 1;
        $sec_match = !in_array('', $secDiagonal) && count(array_unique($secDiagonal)) === 1;

        return $main_match || $sec_match;
    }

    public function checkWinner(): bool {
        return $this->hasHorizontalWin() || $this->hasVerticalWin() || $this->hasDiagonalWin();
    }

    public function setRemainingCells() {
        foreach ($this->cells as $i => $row) {
            foreach ($row as $j => $cell) {
                if (empty($cell)) {
                    $this->setCell($i, $j, "-");
                }
            }
        }
    }


}

?>