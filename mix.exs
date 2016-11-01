defmodule PlugXForwardedProto.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_x_forwarded_proto,
     description: "x-forwarded-proto plug middleware",
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:plug, ">= 0.0.0"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [files: ["lib", "mix.exs", "README*"],
     maintainers: ["Cameron Bytheway"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/exstruct/mazurka_plug"}]
  end
end
