# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_api,
  ecto_repos: [PhoenixApi.Repo]

# Configures the endpoint
config :phoenix_api, PhoenixApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t/9+kd8wSRxVWfV5hvIv3YYd5Wa3L4IkM7WD5KsycJbMW71GzH+FYlGW7b+KTtQY",
  render_errors: [view: PhoenixApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PhoenixApi.PubSub,
  live_view: [signing_salt: "PFXZKrxd"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix_api, PhoenixApi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :phoenix_api, :basic_auth,
  username: "banana",
  password: "nanica123"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
