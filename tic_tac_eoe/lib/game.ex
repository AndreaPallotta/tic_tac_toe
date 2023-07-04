defmodule Game do

  defstruct player1: nil, player2: nil, current_player: nil, winner: nil, board: %Board{}

  def new(p1, p2) do
    %Game{
      player1: p1,
      player2: p2,
      current_player: p1,
      board: Board.new(),
      winner: nil
    }
  end

  def get_current_player(game), do: game.current_player

  def get_board(game), do: game.board

  def get_curr_player_name(game), do: Player.get_name(game.current_player)

  def get_curr_player_mark(game), do: Player.get_mark(game.current_player)

  def make_move(game, row, col) do
    Board.set_cell(game.board, row, col, get_curr_player_mark(game))
  end

  def switch_current_player(game) do
    current_player = game.current_player
    current_player = if current_player == game.player1, do: game.player2, else: game.player1

    %{game | current_player: current_player}
  end

  def display_board(game), do: Board.display(game.board)

  def is_winner(game), do: Board.check_winner(game.board)

  def is_draw(game), do: Board.is_full(game.board)

  def is_over(game) do

    winner = game.winner
    current_player = game.current_player

    if is_draw(game) do
      ^winner = nil
      ^current_player = nil
      true
    end

    if is_winner(game) === true do
      ^winner = current_player
      Utilities.clear_terminal()
      Board.set_remaining_cells(game.board)
      display_board(game)
      true
    end

    false
  end

  def announce_draw() do
    IO.puts("It's a draw!")
  end

  def announce_winner(game) do
    IO.puts("#{get_curr_player_name(game)} is the winner!")
  end

  def make_move(game) do
    input = prompt_user(game)

    case input do
      {:ok, coords} ->
        {row, col} = coords
        Board.set_cell(game.board, row, col, get_curr_player_mark(game))
      {:error, reason} ->
        IO.puts(reason)
        make_move(game)
    end
  end

  defp prompt_user(game) do
    IO.puts("Player '#{get_curr_player_name(game)}', enter row and column (e.g. '1 2'): ")
    input = String.trim(IO.gets(""))

    get_coords_from_input(game, input)
  end

  defp get_coords_from_input(game, input) do
    [row_str, col_str] = String.split(input)
    row = Utilities.parse_coords(row_str, "row")
    col = Utilities.parse_coords(col_str, "column")

    if Board.is_valid_position(game.board, row, col) do
      {:ok, {row - 1, col - 1}}
    else
      {:error, "Invalid row/column input. Try again."}
    end
  rescue
    ArgumentError -> {:error, "Invalid row/column input. Try again."}
  end

  def clear_terminal do
    IO.write(:stdio, <<"\e[2J\e[H">>)
  end

end
