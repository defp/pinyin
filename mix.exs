defmodule Pinyin.Mixfile do
  use Mix.Project

  def project do
    [app: :pinyin,
     version: "0.1.2",
     elixir: "~> 0.14.3-dev",
     deps: deps,
     description: description,
     source_url: "https://github.com/lidashuang/pinyin",
     package: package ]
  end

  def application do
    [applications: []]
  end

  defp description do
    "chinaese pinyin library"
  end

  defp deps do
    []
  end

  defp package do
    [contributors: ["lidashuang"],
     licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/lidashuang/pinyin"}]
  end
end
