defmodule Integration.ChannelsTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "should restrict channels ressource to authenticated user" do
    navigate_to "http://localhost:4001/channels"
    assert page_source =~ "Please sign in before continuing"
  end
end
