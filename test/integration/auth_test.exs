defmodule Integration.AuthTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "home page has login button" do
    navigate_to "http://localhost:4001"
    assert page_source =~ "Welcome to Furby!"
  end
end
