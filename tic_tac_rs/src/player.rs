use crate::utils::Mark;
use crate::board::{Board, BoardTrait};

pub trait PlayerTrait {
    fn get_name(&self) -> &str;
    fn get_mark(&self) -> &Mark;
    fn make_move(&self, board: &mut Board, row: usize, col: usize) -> bool;
}

#[derive(Clone, PartialEq, Eq)]
pub struct Player {
    pub name: String,
    pub mark: Mark,
}

impl PlayerTrait for Player {
    fn get_name(&self) -> &str {
        &self.name
    }

    fn get_mark(&self) -> &Mark {
        &self.mark
    }

    fn make_move(&self, board: &mut Board, row: usize, col: usize) -> bool {
        board.set_cell(row, col, self.mark);
        true
    }
}