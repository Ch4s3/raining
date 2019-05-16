# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :raining,
  ecto_repos: [Raining.Repo]

# Configures the endpoint
config :raining, RainingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dlsOUjXdITONJMzz0UxjwBdJ+imIsIBpBsLhGjH/auWQAOUuqUEqdPe2RWxmEgb+",
  render_errors: [view: RainingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Raining.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "zLMogVhl1CPQC0PsXVXr+wZUr9NXUXQlY+pOE4hRDXGuWyZokMf0NRNezU1Mjfq3"
  ]

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :sentry,
  environment_name: :prod,
  dsn: "https://19aa38276feb495ba5684da857e59534@sentry.io/1459652",
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  tags: %{
    env: "production"
  },
  included_environments: [:prod]

config :darkskyx,
  api_key: System.get_env("DARKSKY_API_KEY"),
  defaults: [
    units: "us",
    lang: "en"
  ]

import_config "scout_apm.exs"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
