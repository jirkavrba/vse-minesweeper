defmodule VseMinesweeperWeb.PageController do
  use VseMinesweeperWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
