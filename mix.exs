defmodule PRT.MixProject do
  use Mix.Project

  def project do
    [
      app: :prt,
      version: "0.1.11",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_deps: :transitive],
      elixirc_paths: elixirc_paths(Mix.env)
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
      {:ecto, "~> 2.2.10 "},
      {:db_connection, "~> 1.1"},
      {:postgrex, "~>  0.13.2"},
      {:dialyxir, "~> 1.0.0-rc.3", runtime: false},
      {:ex_machina, "~> 2.2", only: :test},
      {:bypass, "~> 0.8", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "priv", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
