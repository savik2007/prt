defmodule PRT.MixProject do
  use Mix.Project

  def project do
    [
      app: :prt,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_deps: :transitive],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {PRT, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.2.0"},
      {:poison, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.1"},
      {:dialyxir, "~> 1.0.0-rc.3", runtime: false},
    ]
  end

end
