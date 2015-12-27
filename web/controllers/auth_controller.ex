defmodule Furby.AuthController do
  use Furby.Web, :controller

  alias Phoenix.Controller.Flash

  defmodule User do
    defstruct [:team, :user, :team_id, :user_id]
  end

  def callback(conn, %{"code" => code}) do
    token = Slack.OAuth.get_token!(code: code)
    user = get_user(token.access_token)

    conn
    |> put_session(:access_token, token.access_token)
    |> put_session(:current_user, user)
    |> redirect(to: "/channels")
  end

  def callback(conn, params) do
    conn
    |> put_flash(:error, "Oups! Access denied.")
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp get_user(token) do
    case Slack.Client.get("/auth.test", token) do
      {:ok, %{body: body}} -> struct(User, body)
      {:error, error} ->
        IO.inspect error
        nil
    end
  end
end
