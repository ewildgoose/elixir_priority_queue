defmodule PriorityQueue.Mixfile do
  use Mix.Project

  def project do
    [app: :priority_queue,
     version: "1.0.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Priority Queue for Elixir. Heap implementation",
     package: package(),
     source_url: "https://github.com/ewildgoose/elixir_priority_queue",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:earmark, "~> 0.2.0", only: :docs},
     {:ex_doc, "~> 0.11.0", only: :docs}]
  end

  defp package do
    [files: ~w(lib mix.exs README.md LICENSE),
     maintainers: ["Ed Wildgoose"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/ewildgoose/elixir_priority_queue"}]
  end
end
