defmodule RainingWeb.Router do
  use RainingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug(:put_secure_browser_headers, %{"content-security-policy" => "default-src 'self'"})
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RainingWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RainingWeb do
  #   pipe_through :api
  # end
end
