defmodule TicTacEoe do
  def main do
    Utilities.clear_terminal()
    IO.puts("Welcome to Tic Tac Ex!\n")

    try do
      p1_name = Utilities.get_player_name(1)
      p2_name = Utilities.get_player_name(2)

      p1 = Player.new(p1_name, Utilities.get_o())
      p2 = Player.new(p2_name, Utilities.get_x())

      game = Game.new(p1, p2)

      play_game(game)
    catch exception ->
      IO.puts("An error occurred: #{inspect(exception)}")
      System.halt(1)
    end
  end

  def play_game(game) do
    if Game.is_over(game) do
      IO.puts("Game Over!")

      if Game.is_winner(game) do
        Game.announce_winner(game)
      else
        Game.announce_draw()
      end
    else
      Game.make_move(game)
      Utilities.clear_terminal()
      Io.puts("Here's the updated board\n")

      game.display_board()
      Game.switch_current_player(game)

      IO.puts("It is now #{Game.get_curr_player_name(game)} turn!")

      play_game(game)
    end
  end


end

TicTacEoe.main()
