defmodule Furby.ChannelsController do
  use Furby.Web, :controller

  defmodule Channel do
    defstruct [:created, :creator, :id,
      :is_archived, :is_channel, :is_general, :is_member,
      :members, :name, :num_members, :purpose, :topic]
  end

  def index(conn, _) do
    token = get_session(conn, :access_token)

    response = case Slack.Client.get("/channels.list", token) do
      %{channels: channels} -> channels
      error -> IO.inspect error
    end

    if response do
      channels =
        response
        |> Enum.map(&(struct(Channel, &1)))
      render(conn, "index.html", channels: channels)
    else
      conn
      |> put_flash(:error, "Error loading your channels")
      |> redirect(to: "/")
    end
  end
end
