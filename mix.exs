defmodule PlugXForwardedProto.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_x_forwarded_proto,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:plug, ">= 0.0.0"}]
  end
end
