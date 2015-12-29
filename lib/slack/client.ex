defmodule Slack.Client do
  use HTTPoison.Base

  @endpoint "https://slack.com/api"

  defp process_url(url), do: @endpoint <> url

  defp process_response_body(""), do: ""
  defp process_response_body(body) do
    Poison.decode!(body, keys: :atoms)
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: %{ok: true} = body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{body: %{ok: false, error: error}}} ->
        {:error, reason: error}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason: reason}
    end
  end

  def get(url, token) do
    request(:get, url, "", [], [params: %{token: token}])
    |> handle_response
  end
end
