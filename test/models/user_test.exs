defmodule Furby.UserTest do
  use Furby.ModelCase

  alias Furby.User

  @valid_attrs %{
    access_token: "123",
    image: "http://placeholder.com/avatar",
    name: "John Doe",
    nickname: "jdoe",
    email: "example@mail.com"
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
