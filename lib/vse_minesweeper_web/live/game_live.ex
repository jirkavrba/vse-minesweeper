defmodule VseMinesweeperWeb.GameLive do
  use VseMinesweeperWeb, :live_view

  alias VseMinesweeper.Game

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    # TODO: Do not generate full game, just list of empty tiles
    {:ok, assign(socket, :game, Game.generate_initial())}
  end

  @impl Phoenix.LiveView
  def handle_event("reveal", %{"x" => x, "y" => y}, socket) do
    with {x, _} <- Integer.parse(x),
         {y, _} <- Integer.parse(y) do

      # When revealing the first tile, generate a game, where the clicked tile is always 0
      game = if length(socket.assigns.game.revealed_tiles) == 0,
        do: Game.generate(x, y),
        else: socket.assigns.game

      game = Game.reveal_tile(game, x, y)
      socket = assign(socket, :game, game)

      {:noreply, socket}
    else
      _ -> {:noreply, socket}
    end
  end

  @impl Phoenix.LiveView
  def handle_event("restart", _params, socket) do
    {:noreply, assign(socket, :game, Game.generate_initial())}
  end

  def tile_at(game, x, y) do
    Game.tile_at(game, x, y)
  end
end
