defmodule Arisu.TelemetryWeb.PageController do
  use Arisu.TelemetryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
