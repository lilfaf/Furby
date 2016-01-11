defmodule Furby.ChannelsController do
  require Logger

  use Furby.Web, :controller

  alias Furby.Channel

  plug :authenticate when action in [:update]

  defp current_user(conn), do: get_session(conn, :current_user)

  defp authenticate(conn, _) do
    case current_user(conn) do
      nil ->
        conn
        |> put_flash(:error, "Please sign in before continuing")
        |> redirect(to: "/")
        |> halt
      _ ->
        conn
    end
  end

  def index(conn, _params) do
    # TODO remove this debugging block
    case get_session(conn, :current_user) do
      %{id: user_id} ->
        user = Repo.get(Furby.User, user_id)
        user = Repo.preload(user, :channels)

        Logger.debug "List of channels: #{inspect user.channels}"
      _ ->
    end

    channels = Repo.all(Channel)
    render(conn, "index.html", channels: channels)
  end

  def update(conn, _params) do
    token =
      conn
      |> current_user
      |> Map.fetch!(:access_token)

    case Slack.Client.get("/channels.list", token) do
      {:ok, %{channels: channels}} ->
        # TODO insert channels in database
        channels = Enum.map(channels, fn(c) -> struct(Channel, c) end)

        conn
        |> put_flash(:info, "Channels updated successfully.")
        |> render("index.html", channels: channels)
      {:error, reason: reason} ->
        conn
        |> put_flash(:error, reason)
        |> render("index.html", channels: [])
    end
  end
end
