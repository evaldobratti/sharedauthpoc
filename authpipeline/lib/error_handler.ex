defmodule IdentityWeb.Guardian.ErrorHandler do
  @moduledoc """
  The IdentityWeb Guardian ErrorHandler.
  """

  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  @doc """
  Default error handler for Guardian.

  """
  def auth_error(conn, {_type, reason}, _opts) do
    case reason do
      :already_authenticated ->
        conn
        |> put_flash(:info, "Already authenticated")
        |> redirect(to: "/protected")
        |> halt()

      :unauthenticated ->
        conn
        |> store_current_location()
        |> put_flash(:error, "Authentication required")
        |> redirect(external: "http://identity.lvh.me:4000/")
        |> halt()
    end
  end

  @doc """
  Redirects back to a stored or given location.

  """
  def redirect_back_or(conn, default) do
    case get_session(conn, :redirect_url) do
      nil ->
        redirect(conn, to: default)

      path ->
        conn
        |> delete_session(:redirect_url)
        |> redirect(to: path)
    end
  end

  @doc """
  Stores the current request path in the session.
  """
  def store_current_location(conn) do
    conn
    |> put_session(:redirect_url, conn.request_path)
    |> put_session(:subdomain, String.replace(conn.host, ~r/\..*/, ""))
    |> put_session(:port, conn.port)
  end
end
