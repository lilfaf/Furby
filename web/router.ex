defmodule Furby.Router do
  use Furby.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", Furby do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", Furby do
    pipe_through :browser # Use the default browser stack

    get "/", HomeController, :index
    get "channels", ChannelsController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Furby do
  #   pipe_through :api
  # end

  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
