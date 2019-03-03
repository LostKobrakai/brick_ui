defmodule BrickUiWeb.PageController do
  use BrickUiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
