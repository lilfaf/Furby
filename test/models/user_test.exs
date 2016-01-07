defmodule Furby.UserTest do
  use Furby.ModelCase

  alias Furby.User

  @valid_attrs %{
    access_token: "123",
    avatar: "http://placeholder.com/avatar",
    name: "John Doe",
    nickname: "jdoe",
    slack_user_id: "AB123"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
