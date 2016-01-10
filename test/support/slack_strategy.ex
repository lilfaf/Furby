defmodule Furby.SlackStrategy do
  use Ueberauth.Strategy

  alias Ueberauth.Auth.Info
  alias Ueberauth.Auth.Credentials

  def handle_request!(conn) do
    redirect!(conn, "http://localhost:4001/auth/slack/callback")
  end

  def handle_callback!(conn), do: conn

  def info(_conn) do
    %Info{
      name: "Louis Larpin",
      nickname: "lilfaf",
      email: "louis.larpin@gmail.com",
      image: "https://avatars.slack-edge.com/2015-03-23/4138889823_af317c53eeb1eef1ebbc_48.jpg"
    }
  end

  def credentials(_conn) do
    %Credentials{token: "123"}
  end
end
