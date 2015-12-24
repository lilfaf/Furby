defmodule Slack.Client do
  use HTTPoison.Base

  @endpoint "https://slack.com/api"

  defp process_url(url), do: @endpoint <> url

  defp process_response_body(""), do: ""
  defp process_response_body(body) do
    Poison.decode!(body, keys: :atoms)
  end

  def get(url, token) do
    request(:get, url, "", [], [params: %{token: token}])
  end
end
