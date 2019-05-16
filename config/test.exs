use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :raining, RainingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :sentry,
  environment_name: :test

# Configure your database
config :raining, Raining.Repo,
  username: "postgres",
  password: "postgres",
  database: "raining_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
