import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :telemetry_server, Arisu.Telemetry.Repo,
  username: "postgres",
  password: "postgres",
  database: "telemetry_server_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :telemetry_server, Arisu.TelemetryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "PoxmfaMRI5xiRwUKtBmNDUVn/i7PIdMoLB7NAVXL9c6+DgH7x8qIzeFe5ycKNREJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
