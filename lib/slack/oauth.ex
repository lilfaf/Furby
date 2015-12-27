defmodule Slack.OAuth do
  @moduledoc """
  An OAuth2 strategy for Slack.
  """
  use OAuth2.Strategy

  alias OAuth2.Client
  alias OAuth2.Strategy.AuthCode

  @default_scopes ["channels:read", "users:read"]

  defp config do
    [strategy: Slack.OAuth,
      site: "https://slack.com",
      authorize_url: "/oauth/authorize",
      token_url: "/api/oauth.access"]
  end

  # Public API

  def client do
    Application.get_env(:furby, Slack.OAuth)
    |> Keyword.merge(config())
    |> Client.new()
  end

  def authorize_url!(scopes \\ [], params \\ []) do
    scope =
      scopes ++ @default_scopes
      |> Enum.uniq
      |> Enum.join(" ")

    client()
    |> put_param(:scope, scope)
    |> Client.authorize_url!(params)
  end

  def get_token!(params \\ [], headers \\ []) do
    Client.get_token!(client(), params, headers)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
