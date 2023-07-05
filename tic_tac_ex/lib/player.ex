defmodule Player do
  defstruct [:name, :mark]

  def new(name, mark) do
    %__MODULE__{name: name, mark: mark}
  end

  def get_name(player), do: player.name

  def get_mark(player), do: player.mark
end
