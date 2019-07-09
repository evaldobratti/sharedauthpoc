defmodule IdentityWeb.Guardian.AuthPipeline do

  use Guardian.Plug.Pipeline,
    error_handler: IdentityWeb.Guardian.ErrorHandler,
    module: IdentityWeb.Guardian,
    otp_app: :identity

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
