defmodule PlugXForwardedProto do
  @behaviour Plug
  import Plug.Conn

  def init(_) do
    nil
  end

  def call(conn, _opts) do
    case get_req_header(conn, "x-forwarded-proto") do
      [] ->
        conn
      [proto | _] ->
        %{scheme: orig_scheme, port: orig_port} = conn
        scheme = choose_scheme(orig_scheme, proto)
        port = choose_port(orig_port, scheme, orig_scheme)
        %{conn | scheme: scheme, port: port}
    end
  end

  defp choose_scheme(:ws, "http"), do: :ws
  defp choose_scheme(:ws, "https"), do: :wss
  defp choose_scheme(:wss, "https"), do: :wss
  defp choose_scheme(_, "http"), do: :http
  defp choose_scheme(_, "https"), do: :https
  defp choose_scheme(_, proto), do: String.to_existing_atom(proto)

  defp choose_port(80, :https, :http), do: 443
  defp choose_port(80, :wss, :ws), do: 443
  defp choose_port(port, _, _), do: port
end
