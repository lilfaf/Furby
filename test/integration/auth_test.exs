defmodule Integration.AuthenticationTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "user sign in with slack successfully" do
    navigate_to "http://localhost:4001"
    assert page_source =~ "Welcome to Furby!"

    click find_element :id, "home-login-btn"
    assert page_source =~ "Connected as Louis Larpin"
  end
end
