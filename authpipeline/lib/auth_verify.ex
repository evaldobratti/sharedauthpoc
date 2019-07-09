defmodule IdentityWeb.AuthVerify do

  use Plug.Builder

  plug IdentityWeb.Guardian.AuthPipeline
  plug IdentityWeb.Plug.CurrentUser

end
