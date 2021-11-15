defmodule VseMinesweeperWeb.GameLive do
  use VseMinesweeperWeb, :live_view

  alias VseMinesweeper.Game

  @impl true
  def mount(_params, _session, socket) do
    socket = socket
    |> assign(:game, Game.generate())
    |> assign(:flags_placed, [])
    |> assign(:tiles_revealed, [])
    |> assign(:game_over, false)

    {:ok, assign(socket, :game, Game.generate())}
  end
end
