defmodule IdentityWeb.Router do
  use IdentityWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :login_required do
    plug IdentityWeb.AuthVerify
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IdentityWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :sign_in
  end

  scope "/protected", IdentityWeb do
    pipe_through [:browser, :login_required]

    get "/", PageController, :protected
    post "/logout", PageController, :logout
  end
end
