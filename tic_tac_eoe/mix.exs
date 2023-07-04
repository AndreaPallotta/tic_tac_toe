defmodule TicTacEoe.MixProject do
  use Mix.Project

  def project do
    [
      app: :tic_tac_eoe,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
