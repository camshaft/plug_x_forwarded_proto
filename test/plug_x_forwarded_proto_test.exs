defmodule PlugXForwardedProtoTest do
  use ExUnit.Case

  @subject PlugXForwardedProto
  @opts @subject.init([])

  test "default" do
    %{scheme: :http, port: 80} =
      conn("http://example.com/")
      |> @subject.call(@opts)
  end

  test "http" do
    %{scheme: :http, port: 80} =
      conn("http://example.com/", [{"x-forwarded-proto", "http"}])
      |> @subject.call(@opts)
  end

  test "https" do
    %{scheme: :https, port: 443} =
      conn("http://example.com/", [{"x-forwarded-proto", "https"}])
      |> @subject.call(@opts)
  end

  test "http port" do
    %{scheme: :http, port: 4000} =
      conn("http://example.com:4000/", [{"x-forwarded-proto", "http"}])
      |> @subject.call(@opts)
  end

  test "https port" do
    %{scheme: :https, port: 4000} =
      conn("https://example.com:4000/", [{"x-forwarded-proto", "https"}])
      |> @subject.call(@opts)
  end

  test "ws default" do
    %{scheme: :ws, port: 80} =
      conn("ws://example.com/")
      |> @subject.call(@opts)
  end

  test "ws" do
    %{scheme: :ws, port: 80} =
      conn("ws://example.com/", [{"x-forwarded-proto", "http"}])
      |> @subject.call(@opts)
  end

  test "wss" do
    %{scheme: :wss, port: 80} =
      conn("wss://example.com/", [{"x-forwarded-proto", "https"}])
      |> @subject.call(@opts)
  end

  test "ws port" do
    %{scheme: :ws, port: 4000} =
      conn("ws://example.com:4000/", [{"x-forwarded-proto", "http"}])
      |> @subject.call(@opts)
  end

  test "wss port" do
    %{scheme: :wss, port: 4000} =
      conn("wss://example.com:4000/", [{"x-forwarded-proto", "https"}])
      |> @subject.call(@opts)
  end

  defp conn(uri, headers \\ []) do
    %Plug.Conn{req_headers: headers}
    |> Plug.Adapters.Test.Conn.conn("GET", uri, nil)
  end
end
