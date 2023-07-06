#!/usr/bin/php

<?php
require "game.php";
require "player.php";
require "utils.php";

require "board.php";

function main() {
    clearTerminal();
    echo "Welcome to Tic Tac Php!", nline(2);

    try {
        $roundCounter = 1;

        $p1Name = getUserName(1);
        $p2Name = getUserName(2);

        $p1 = new Player($p1Name, Mark::O);
        $p2 = new Player($p2Name, Mark::X);

        print_nline(1);
        
        $game = new Game($p1, $p2);
        $game->display();

        while (true) {
            $game->makeMove();

            $roundCounter++;
            clearTerminal();
            echo "Here's the updated board. Round $roundCounter\n";

            $game->display();

            if ($game->isOver()) {
                break;
            }

            $game->switchCurrentPlayer();

            $currName = $game->currentPlayer->name;
            echo "It is now $currName turn!\n";
        }

    } catch (Exception $e) {
        echo "An error has been found: " , $e->getMessage() , "\n";
    }
}

main();
?>