defmodule Furby.AuthController do
  use Furby.Web, :controller

  plug Ueberauth

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
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
        |> put_session(:current_user, user)
        |> redirect(to: "/channels")
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Invalid informations from Slack")
        |> redirect(to: "/")
    end
  end
end
