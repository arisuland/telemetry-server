defmodule Arisu.Telemetry.Repo do
  use Ecto.Repo,
    otp_app: :telemetry_server,
    adapter: Ecto.Adapters.Postgres
end
