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
      {:ok, %{body: %{channels: channels}}} -> channels
      {:ok, %{body: %{error: "not_authed"}}} ->
        IO.inspect("No authentication token provided")
      {:ok, %{body: %{error: "invalid_auth"}}} ->
        IO.inspect("Invalid authentication token")
      {:ok, %{body: %{error: "account_inactive"}}} ->
        IO.inspect("Authentication token is for a deleted user or team")
    end
    channels = response |> Enum.map(&(struct(Channel, &1)))
    render(conn, "index.html", channels: channels)
  end
end
