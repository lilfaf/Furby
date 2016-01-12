defmodule Furby.Factory do
  use ExMachina.Ecto, repo: Furby.Repo

  alias Furby.User
  alias Furby.Channel

  def factory(:user) do
    %User{
      name: "John Doe",
      email: sequence(:email, &"email-#{&1}@example.com"),
      nickname: "jdoe",
      image: "http://placeholder.com/avatar",
      access_token: "123"
    }
  end

  def factory(:channel) do
    %Channel{
      created: 42,
      creator: "LL1234",
      is_archived: true,
      is_channel: true,
      is_general: true,
      is_member: true,
      members: ["LL1234"],
      name: "Dummy name",
      num_members: 42,
      slack_id: "CC1234"
    }
  end
end
