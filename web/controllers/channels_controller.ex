defmodule Furby.ChannelsController do
  use Furby.Web, :controller

  defmodule Channel do
    defstruct [:created,
               :creator,
               :id,
               :is_archived,
               :is_channel,
               :is_general,
               :is_member,
               :members,
               :name,
               :num_members,
               :purpose,
               :topic]
  end

  def index(conn, _params) do
    token = get_session(conn, :current_user).access_token

    case Slack.Client.get("/channels.list", token) do
      {:ok, %{channels: channels}} ->
        channels = Enum.map(channels, fn(c) -> struct(Channel, c) end)

        render(conn, "index.html", channels: channels)
      {:error, reason: reason} ->
        conn
        |> put_flash(:error, reason)
        |> render("index.html", channels: [])
    end
  end
end
