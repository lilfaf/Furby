defmodule Furby.HomeView do
  use Furby.Web, :view

  def authorize_url do
    Slack.OAuth.authorize_url!(["users:read"])
  end
end
