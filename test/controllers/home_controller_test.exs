defmodule Furby.HomeControllerTest do
  use Furby.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Furby!"
  end
end
