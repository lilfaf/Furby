defmodule Furby.ChannelTest do
  use Furby.ModelCase

  alias Furby.Channel

  @valid_attrs %{
    created: 42,
    creator: "some content",
    is_archived: true,
    is_channel: true,
    is_general: true,
    is_member: true,
    members: ["some content"],
    name: "some content",
    num_members: 42,
    slack_id: "some content"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Channel.changeset(%Channel{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Channel.changeset(%Channel{}, @invalid_attrs)
    refute changeset.valid?
  end
end
