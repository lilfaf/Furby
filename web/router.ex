defmodule Furby.Router do
  use Furby.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Furby do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    scope "/auth" do
      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
      delete "/logout", AuthController, :delete
    end

    get "channels", ChannelsController, :index
    put "channels", ChannelsController, :update

    get "/", HomeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Furby do
  #   pipe_through :api
  # end
end
