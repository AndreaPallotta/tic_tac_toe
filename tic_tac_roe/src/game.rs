use std::borrow::BorrowMut;

use crate::board::{Board, BoardTrait};
use crate::player::{Player, PlayerTrait};
use crate::utils;

pub trait GameTrait<'a> {
    fn get_current_player(&mut self) -> Option<&'a Player>;
    fn get_board(&mut self) -> &mut Board;
    fn switch_current_player(&mut self);
    fn display(&self);
    fn is_winner(&self) -> bool;
    fn is_draw(&self) -> bool;
    fn is_over(&mut self) -> bool;
    fn announce_draw(&self);
    fn announce_winner(&self);
    fn get_player_move(&self) -> Result<(usize, usize), &'static str> ;
}

#[derive(Clone)]
pub struct Game<'a> {
    pub board: Board,
    pub player1: &'a Player,
    pub player2: &'a Player,
    pub current_player: Option<&'a Player>,
    pub winner: Option<&'a Player>
}

impl<'a> Game<'a> {
    pub fn new(player1: &'a Player, player2: &'a Player) -> Self {
        let winner = None;
        let board = Board::new(Some(3));

        Game {
            board,
            player1: player1,
            player2,
            current_player: Some(player1),
            winner
        }
    }
}

impl<'a> GameTrait<'a> for Game<'a> {
    fn get_current_player(&mut self) -> Option<&'a Player> {
        self.current_player
    }

    fn get_board(&mut self) -> &mut Board {
        self.board.borrow_mut()
    }

    fn switch_current_player(&mut self) {
        self.current_player = if self.current_player == Some(&self.player1) {
            Some(&self.player2)
        } else {
            Some(&self.player1)
        }
    }

    fn display(&self) {
        self.board.display();
    }

    fn is_winner(&self) -> bool {
        self.board.check_winner()
    }

    fn is_draw(&self) -> bool {
        self.board.is_full()
    }

    fn is_over(&mut self) -> bool {
        if self.is_draw() {
            self.winner = None;
            self.current_player = None;
            return true;
        }

        if self.is_winner() {
            self.winner = self.current_player;
            utils::clear_terminal();
            self.board.set_remaining_cells();
            self.display();
            return true;
        }

        false
    }

    fn announce_draw(&self) {
        println!("It is a draw!");
    }

    fn announce_winner(&self) {
        println!("{} is the winner!\n", self.winner.unwrap().get_name());
    }

    fn get_player_move(&self) -> Result<(usize, usize), &'static str> {
        loop {
            println!("Player '{}', enter row and column (e.g. '1 2'): ", self.current_player.unwrap().get_name());

            let input_str = match utils::handle_user_input() {
                Ok(input) => input,
                Err(err) => return Err(err),
            };

            match utils::parse_input(&input_str, &self.board) {
                Ok((row, col)) => return Ok((row, col)),
                Err(err) => println!("{}", err)
            }
        }
    }
}