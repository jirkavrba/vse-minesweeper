defmodule VseMinesweeperWeb.GameLive do
  use VseMinesweeperWeb, :live_view

  alias VseMinesweeper.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :game, Game.generate())}
  end
end
