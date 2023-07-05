defmodule Utilities do
  @mark [:X, :O]

  def get_x, do: List.first(@mark)
  def get_o, do: List.last(@mark)

  def mark_to_string(mark) do
    case mark do
      :X -> "X"
      :O -> "O"
      _ -> "-"
    end
  end

  def is_blank(nil), do: true
  def is_blank(val) when is_binary(val), do: String.trim(val) == ""

  def get_matrix_diags(board) do
    size = Board.get_size()

    {diag1, diag2} =
      board
      |> Enum.with_index()
      |> Enum.reduce({[], []}, fn {row, i}, {diag1_acc, diag2_acc} ->
        first_el = Enum.at(row, i)
        second_el = Enum.at(row, size - i - 1)

        {diag1_acc ++ [String.trim(first_el)], diag2_acc ++ [String.trim(second_el)]}
      end)

      {diag1, diag2}
  end

  def parse_coords(coord_str, coord_name) do
    case Integer.parse(coord_str) do
      {coord, _} when coord > 0 ->
        coord
      _ ->
        raise ArgumentError, "Invalid #{coord_name} value '#{coord_str}'."
    end
  end

  def clear_terminal do
    IO.write(:stdio, <<"\e[2J\e[H">>)
  end

  def get_player_name(player_number) do
    def_name = "Player #{player_number}"
    IO.puts("Insert Player #{player_number} name (default '#{def_name}'): ")
    input = String.trim(IO.gets(""))

    if String.trim(input) == "" do
      def_name
    else
      input
    end
  end

end
