defmodule SimpleBudget.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_budget,
      version: "0.1.0",
      elixir: "1.15.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: test_coverage()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {SimpleBudget.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp test_coverage do
    [
      ignore_modules: [
        SimpleBudget.Application,
        SimpleBudget.DataCase,
        SimpleBudget.Release,
        SimpleBudget.Repo,
        SimpleBudgetWeb.CoreComponents,
        SimpleBudgetWeb.ErrorHTML,
        SimpleBudgetWeb.Telemetry,
        SimpleBudgetWeb.Gettext
      ]
    ]
  end

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:assent, "~> 0.2.2"},
      {:castore, "~> 1.0"},
      {:certifi, "~> 2.4"},
      {:ecto_sql, "~> 3.10"},
      {:esbuild, "~> 0.7.1", runtime: Mix.env() == :dev},
      {:finch, "~> 0.16"},
      {:floki, ">= 0.30.0", only: :test},
      {:gettext, "~> 0.22"},
      {:heroicons, "~> 0.5"},
      {:jason, "~> 1.2"},
      {:mint, "~> 1.0"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_dashboard, "~> 0.8.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.19.0"},
      {:phoenix, "~> 1.7.6"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:swoosh, "~> 1.3"},
      {:tailwind, "~> 0.2.1", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
