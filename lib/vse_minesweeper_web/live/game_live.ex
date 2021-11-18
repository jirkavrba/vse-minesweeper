defmodule VseMinesweeperWeb.GameLive do
  use VseMinesweeperWeb, :live_view

  alias VseMinesweeper.Game

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :game, Game.generate())}
  end

  @impl Phoenix.LiveView
  def handle_event("reveal", %{"x" => x, "y" => y}, socket) do
    with {x, _} <- Integer.parse(x),
         {y, _} <- Integer.parse(y) do

      game = Game.reveal_tile(socket.assigns.game, x, y)
      socket = assign(socket, :game, game)

      {:noreply, socket}
    else
      _ -> {:noreply, socket}
    end
  end

  def tile_at(%Game{tiles: tiles, width: width}, x, y) do
    Enum.at(tiles, y * width + x)
  end
end
