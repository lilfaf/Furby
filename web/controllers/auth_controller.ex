defmodule Furby.AuthController do
  use Furby.Web, :controller

  plug Ueberauth

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Furby.User.from_ueberauth(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated")
        |> Guardian.Plug.sign_in(user, :token)
        |> redirect(to: "/channels")
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Invalid informations from Slack")
        |> redirect(to: "/")
    end
  end
end
