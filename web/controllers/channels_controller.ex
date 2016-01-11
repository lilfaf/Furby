defmodule Furby.ChannelsController do
  use Furby.Web, :controller
  use Guardian.Phoenix.Controller

  alias Furby.Channel

  plug Guardian.Plug.EnsureAuthenticated, handler: Furby.AuthErrorHandler

  def index(conn, _params, user, _claims) do
    channels = Repo.all(Channel)
    render(conn, "index.html", channels: channels)
  end

  def update(conn, _params, user, _claims) do
    case Slack.Client.get("/channels.list", user.access_token) do
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
