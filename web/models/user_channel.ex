defmodule Furby.UserChannel do
  use Furby.Web, :model

  schema "user_channels" do
    belongs_to :user, Furby.User
    belongs_to :channel, Furby.Channel
  end
end
