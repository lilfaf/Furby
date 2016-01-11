defmodule Furby.AuthErrorHandler do
  import Plug.Conn

  alias Phoenix.Controller

  def unauthenticated(conn, _params) do
    conn
    |> Controller.put_flash(:error, "Please sign in before continuing")
    |> Controller.redirect(to: "/")
  end
end
