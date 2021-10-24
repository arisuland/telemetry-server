defmodule Arisu.Telemetry.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Arisu.Telemetry.Repo,
      # Start the Telemetry supervisor
      Arisu.TelemetryWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Arisu.Telemetry.PubSub},
      # Start the Endpoint (http/https)
      Arisu.TelemetryWeb.Endpoint
      # Start a worker by calling: Arisu.Telemetry.Worker.start_link(arg)
      # {Arisu.Telemetry.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Arisu.Telemetry.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Arisu.TelemetryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
