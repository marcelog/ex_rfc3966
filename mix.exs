defmodule RFC3966.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_rfc3966,
     name: "ex_rfc3966",
     version: "0.2.2",
     source_url: "https://github.com/marcelog/ex_rfc3966",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    A "tel" URI parser trying to be strictly compatible with RFC3966. Uses official ABNF grammar and ex_abnf as interpreter.
    """
  end

  defp deps do
    [
      {:ex_abnf, "~> 0.2.7"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*", "priv"],
      maintainers: ["Marcelo Gornstein"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/marcelog/ex_rfc3966"
      }
    ]
  end
end
