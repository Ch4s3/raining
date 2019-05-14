defmodule RainingWeb.PageController do
  use RainingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
