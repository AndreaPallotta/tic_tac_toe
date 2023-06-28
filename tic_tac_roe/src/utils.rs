use std::{fmt::Display, io};

use crate::{board::{Board, BoardTrait}};

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Mark {
    O,
    X
}

impl Display for Mark {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Mark::O => write!(f, "O"),
            Mark::X => write!(f, "X")
        }
    }
}

pub fn clear_terminal() {
    print!("\x1B[2J\x1B[1;1H");
}


pub fn handle_user_input() -> Result<String, &'static str> {
    let mut input_str = String::new();
    match io::stdin().read_line(&mut input_str) {
        Ok(_) => Ok(input_str.trim().to_string()),
        Err(_) => Err("Failed to read input.")
    }
}

pub fn parse_input(input_str: &str, board: &Board) -> Result<(usize, usize), &'static str> {
    let fields: Vec<&str> = input_str.trim().split(' ').collect();
    
    if fields.len() != 2 {
        return Err("Invalid Input. Please enter row and column separated by a space.");
    }

    let row = fields[0].parse::<usize>().map_err(|_| "Invalid input. Please enter valid row and column.")?;
    let col = fields[1].parse::<usize>().map_err(|_| "Invalid input. Please enter valid row and column.")?;

    if !board.is_valid_position(row - 1 , col - 1) {
        return Err("Invalid input. Please enter valid row and column.");
    }

    Ok((row - 1, col - 1))
}

pub fn get_player_name(default_name: &str, player_number: usize) -> String {
    println!("insert Player '{}' name (default '{}'): ", player_number, default_name);
    
    match handle_user_input() {
        Ok(input) => {
            let trimmed_input = input.trim();
            if trimmed_input.is_empty() {
                default_name.to_string()
            } else {
                trimmed_input.to_string()
            }
        },
        Err(_) => default_name.to_string()
    }
}
