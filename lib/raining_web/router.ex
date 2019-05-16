defmodule RainingWeb.Router do
  use RainingWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery

    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RainingWeb do
    pipe_through :browser

    # get "/", PageController, :index

    live("/", WeatherLive)
  end

  # Other scopes may use custom stacks.
  # scope "/api", RainingWeb do
  #   pipe_through :api
  # end
end
