use tic_tac_roe::utils;
use tic_tac_roe::game::{Game, GameTrait};
use tic_tac_roe::player::{Player, PlayerTrait};
use tic_tac_roe::board::BoardTrait;

fn main() {
    utils::clear_terminal();
    println!("Welcome to Tic Tac Roe!");

    let p1_name = utils::get_player_name("Player 1", 1);
    let p2_name = utils::get_player_name("Player 2", 2);

    let p1 = Player {
        name: p1_name.clone(),
        mark: utils::Mark::O,
    };
    let p2 = Player {
        name: p2_name.clone(),
        mark: utils::Mark::X,
    };

    let mut game = Game::new(&p1, &p2);

    game.display();

    let mut round_counter = 1;

    while !game.is_over() {
        let move_ = match game.get_player_move() {
            Ok(m) => m,
            Err(error) => {
                println!("Error: {}", error);
                continue;
            }
        };

        let current_player = game.get_current_player().unwrap();
        let is_valid = current_player.make_move(game.get_board(), move_.0, move_.1);

        if !is_valid {
            println!("Invalid move. Try again");
            continue;
        }

        round_counter += 1;
        utils::clear_terminal();
        println!("Here's the updated board. Round {}", round_counter);
        println!();
        game.board.display();

        if game.is_over() {
            break;
        }

        game.switch_current_player();
        println!(
            "\nIt is now {}'s turn!",
            game.get_current_player().unwrap().get_name()
        );
    }

    println!("Game over!");

    if game.is_draw() {
        game.announce_draw();
    } else {
        game.announce_winner();
    }
}
