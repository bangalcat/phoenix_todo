# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_todo,
  ecto_repos: [PhoenixTodo.Repo]

# Configures the endpoint
config :phoenix_todo, PhoenixTodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jrIU3EADBm/LnMOE+vKq/K74x9aaKRT9nhyYNX2z0/6AUuVTDgxMLmPpAXKb5U1j",
  render_errors: [view: PhoenixTodoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixTodo.PubSub,
  live_view: [signing_salt: "fp+YZLyU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
