defmodule Board do
  defstruct [:cells]

  @size 3

  def new do
    cells = for _ <- 1..@size, do: for _ <- 1..@size, do: "   "
    %__MODULE__{cells: cells}
  end

  def get_size, do: @size

  def get_cells(board), do: board.cells

  def is_valid_position(board, row, col) do
    if row < 0 or row >= @size or col < 0 or col >= @size do
      false
    else
      cell = get_cells(board)[row][col] |> Utilities.is_blank()

      if not cell and cell != "-" do
        false
      else
        true
      end
    end
  end

  def get_cell(board, row, col) do
    if not is_valid_position(board, row, col) do
      raise "Invalid row or column value"
    else
      get_cells(board)[row][col]
    end
  end

  def set_cell(board, row, col, mark \\ "") do
    if not is_valid_position(board, row, col) do
      raise "Invalid row or column value. Try again"
    else
      mark_str = Utilities.mark_to_string(mark)
      new_cells = put_in(get_cells(board), [row, col], " " <> mark_str <> " ")
      %__MODULE__{board | cells: new_cells}
    end
  end

  def display(board) do
    IO.puts("")
    IO.puts("      c1  c2  c3")
    IO.puts("    -------------")

    for i <- 0..@size-1 do
      IO.write("r#{i+1} |")

      for j <- 0..@size-1 do
        IO.write("#{get_cell(board, i, j)}|")
      end

      IO.puts("")

      if i < @size-1 do
        IO.puts("    -------------")
      end
    end

    IO.puts("")
  end

  def is_full(board) do
    not Enum.any?(get_cells(board), fn row ->
      Enum.any?(row, fn cell ->
        trimmed_cell = String.trim(cell)
        trimmed_cell == "" or trimmed_cell == " - "
      end)
    end)
  end

  def has_horizontal_win(board) do
    for row <- get_cells(board) do
      trimmed_row = for cell <- row, do: String.trim(cell)
      if hd(trimmed_row) != "" and Enum.all?(trimmed_row, &(&1 == hd(trimmed_row))) do
        true
      end
     end

     false
  end

  def has_vertical_win(board) do
    size = get_size()

    Enum.any?(0..(size - 1), fn i ->
      column = Enum.map(get_cells(board), fn row ->
        String.trim(row |> Enum.at(i))
      end)

      column != [] && Enum.uniq(column) == [hd(column)]
    end)
  end

  def has_diagonal_win(board) do
    {diagonal1, diagonal2} = Utilities.get_matrix_diags(get_cells(board))

    Enum.all?(diagonal1, fn cell ->
      cell != "" && cell == hd(diagonal1)
    end) ||
    Enum.all?(diagonal2, fn cell ->
      cell != "" && cell == hd(diagonal2)
    end)
  end

  def check_winner(board) do
    has_horizontal_win(board) || has_vertical_win(board) || has_diagonal_win(board)
  end

  def set_remaining_cells(board) do
    for {row, i} <- get_cells(board) do
      for {cell, j} <- row do
        if String.trim(cell) == "" do
          set_cell(board, i, j, "")
        end
      end
    end
  end
end
