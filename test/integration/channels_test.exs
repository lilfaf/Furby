defmodule Integration.ChannelsTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "user cant refresh channels list when not logged in" do
    navigate_to "http://localhost:4001/channels"
    click find_element :id, "channels-refresh-btn"

    assert page_source =~ "Please sign in before continuing"
  end
end
