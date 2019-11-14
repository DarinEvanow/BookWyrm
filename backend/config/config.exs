# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bookwyrm,
  ecto_repos: [Bookwyrm.Repo]

# Configures the endpoint
config :bookwyrm, BookwyrmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "irk5ybKg/vwvYtw9/mHJwEDj1S5nASAzPP9vItytSAJacaijnH+Oa3d4d6YDTM6e",
  render_errors: [view: BookwyrmWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Bookwyrm.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
