defmodule Furby.HomeController do
  use Furby.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
