use crate::utils::Mark;

pub trait BoardTrait {
    fn get_size(&self) -> &usize;
    fn get_cells(&self) -> &Vec<Vec<String>>;
    fn is_valid_position(&self, row: usize, col: usize) -> bool;
    fn get_cell(&self, row: usize, col: usize) -> &str;
    fn set_cell(&mut self, row: usize, col: usize, mark: Mark);
    fn display(&self);
    fn is_full(&self) -> bool;
    fn has_horizontal_win(&self) -> bool;
    fn has_vertical_win(&self) -> bool;
    fn has_diagonal_win(&self) -> bool;
    fn check_winner(&self) -> bool;
    fn set_remaining_cells(&mut self);
}

#[derive(Clone)]
pub struct Board {
    pub cells: Vec<Vec<String>>,
    pub size: usize
}

impl Board {
    pub fn new(size: Option<usize>) -> Self {
        let size = size.unwrap_or(3);
        let cells = vec![vec!["   ".to_string(); size]; size];
        Board { cells, size }
    }
}

impl BoardTrait for Board {
    fn get_size(&self) -> &usize {
        &self.size
    }

    fn get_cells(&self) -> &Vec<Vec<String>> {
        &self.cells
    }

    fn is_valid_position(&self, row: usize, col: usize) -> bool {
        if row >= self.size || col >= self.size {
            return false;
        }
        if !self.cells[row][col].trim().is_empty() {
            return false;
        }
        return true;
    }

    fn get_cell(&self, row: usize, col: usize) -> &str {
        if !self.is_valid_position(row, col) {
            panic!("Invalid row or column value. Try again");
        }
        &self.cells[row][col].as_str()
    }

    fn set_cell(&mut self, row: usize, col: usize, mark: Mark) {
        if !self.is_valid_position(row, col) {
            panic!("Invalid row or column value. Try again");
        }

        self.cells[row][col] = format!(" {} ", mark);
    }

    fn display(&self) {
        println!("      c1  c2  c3");
        println!("    -------------");

        for i in 0..self.cells.len() {
            print!("r{}  |", i + 1);

            for j in 0..self.cells[i].len() {
                print!("{}|", self.cells[i][j]);
            }

            println!();

            if i < 2 {
                println!("    -------------");
            }
        }

        println!("    -------------");
    }

    fn is_full(&self) -> bool {
        self.cells.iter().all(|row| {
            row.iter().all(|cell| {
                let trimmed_cell = cell.trim();
                trimmed_cell != "" && trimmed_cell != "-"
            })
        })
    }

    fn has_horizontal_win(&self) -> bool {
        for row in &self.cells {
            let trimmed_row: Vec<&str> = row.iter().map(|cell| cell.trim()).collect();

            if trimmed_row.iter().all(|&cell| cell != "" && cell == trimmed_row[0])  {
                return true;
            }
        }

        false
    }

    fn has_vertical_win(&self) -> bool {
        for col in (0..self.size).map(|i| self.cells.iter().map(|row| &row[i]).collect::<Vec<_>>()) {
            let trimmed_col: Vec<&str> = col.iter().map(|cell| cell.trim()).collect();

            if trimmed_col.iter().all(|&cell| cell != "" && cell == trimmed_col[0])  {
                return true;
            }
        }

        false
    }

    fn has_diagonal_win(&self) -> bool {
        if self.cells[0][0].trim() != "" && (0..self.size).all(|i| self.cells[i][i].trim() == self.cells[0][0].trim()) {
            return true
        }

        if self.cells[0][self.size - 1].trim() != "" && (0..self.size).all(|i| self.cells[i][self.size - i - 1].trim() == self.cells[0][self.size - 1].trim()) {
            return true
        }

        false
    }

    fn check_winner(&self) -> bool {
        self.has_horizontal_win() || self.has_vertical_win() || self.has_diagonal_win()
    }

    fn set_remaining_cells(&mut self) {
        for row in self.cells.iter_mut() {
            *row = row.iter().map(|cell| {
                if cell.trim() == "" {
                    " - ".to_string()
                } else {
                    cell.to_string()
                }
            }).collect::<Vec<_>>();
        }
    }

}

