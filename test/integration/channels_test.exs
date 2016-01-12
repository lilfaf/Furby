defmodule Integration.ChannelsTest do
  use ExUnit.Case
  use Hound.Helpers

  alias Furby.Factory

  hound_session

  test "should restrict channels ressource to authenticated user" do
    navigate_to "http://localhost:4001/channels"
    assert page_source =~ "Please sign in before continuing"
  end

  test "should list channels" do
    Factory.create(:channel, name: "foo")
    Factory.create(:channel, name: "bar")

    navigate_to "http://localhost:4001/"
    click find_element(:id, "home-login-btn")

    assert page_source =~ "# foo"
    assert page_source =~ "# bar"
  end
end
