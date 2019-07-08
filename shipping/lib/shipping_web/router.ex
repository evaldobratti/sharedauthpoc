defmodule ShippingWeb.Router do
  use ShippingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug IdentityWeb.AuthVerify
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShippingWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShippingWeb do
  #   pipe_through :api
  # end
end
