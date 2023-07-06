<?php
    class Mark {
        const O = "O";
        const X = "X";
    }

    function clearTerminal() {
        echo "\x1B[2J\x1B[H";
    }

    function nline(int $num = 1): string {
        return str_repeat("\n", $num);
    }

    function print_nline(int $num = 1) {
        echo nline($num);
    }

    function getUserName(int $playerNum): string {
        $defName = "Player $playerNum";

        $input = readline("Insert Player $playerNum name (default '$defName'): ");
        $trimmedInput = trim($input);

        return empty($trimmedInput) ? $defName : $trimmedInput;
    }

    function getUserInput(string $playerName): array {
        $input = trim(readline("Player $playerName, enter row and column (e.g. '1 2'): "));

        return explode(" ", $input);
    }

    function inputToCoords(array $input): array {
        if (count($input) != 2) {
            throw new Exception("Invalid row or column. Try again");
        }

        try {
            $row = intval($input[0]);
            $col = intval($input[1]);

            return array($row - 1, $col - 1);
        } catch (err) {
            throw new Exception("Invalid row or column. Try again");
        }
    }
?>