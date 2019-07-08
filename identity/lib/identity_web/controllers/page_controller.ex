defmodule IdentityWeb.PageController do
  use IdentityWeb, :controller

  alias IdentityWeb.Guardian

  def index(conn, _params) do
    render(conn, "index.html", csrf: get_csrf_token())
  end

  def sign_in(conn, param) do
    if Map.get(param, "username") == "admin" do
      conn
      |> Guardian.Plug.sign_in(param)
      |> put_flash(:info, "Signed in successfully")
      |> redirect_previous_location()
    else
      logout(conn, param)
    end
  end

  def redirect_previous_location(conn) do
    previous_path = get_session(conn, :redirect_url)
    subdomain = get_session(conn, :subdomain)
    port = get_session(conn, :port)
    domain = String.split_at(conn.host, :binary.match(conn.host, ".") |> elem(0)) |> elem(1)

    if previous_path == nil and subdomain == nil do
      redirect(conn, to: "/protected")
    else
      conn
      |> redirect(external: "http://" <> subdomain <> domain <> ":" <> Integer.to_string(port) <> previous_path)
    end
  end

  def logout(conn, _param) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:error, "You are not logged!")
    |> redirect(to: "/")
  end

  def protected(conn, _params) do
    render(conn, "protected.html", csrf: get_csrf_token())
  end
end
