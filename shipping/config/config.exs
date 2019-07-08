# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :shipping, ShippingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h58mZ7ga/pSN7D086CyuyPz5ATO3L3S7cWqHEbF/I2jlr9N1IxB6HcUds4OnXYo0",
  render_errors: [view: ShippingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Shipping.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :identity, IdentityWeb.Guardian,
       issuer: "authpoc_web",
       secret_key: "a secret"
