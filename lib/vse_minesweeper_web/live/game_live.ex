defmodule VseMinesweeperWeb.GameLive do
  use VseMinesweeperWeb, :live_view

  alias VseMinesweeper.Game

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket = socket
    |> assign(:game, Game.generate_initial())
    |> assign(:placing_flags, false)

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("reveal", %{"x" => x, "y" => y}, socket) do
    with {x, _} <- Integer.parse(x),
         {y, _} <- Integer.parse(y) do

      # When revealing the first tile, generate a game, where the clicked tile is always 0
      game = if length(socket.assigns.game.revealed_tiles) == 0,
        do: Game.generate(x, y),
        else: socket.assigns.game

      if (socket.assigns.placing_flags) do
        {:noreply, assign(socket, :game, Game.toggle_flag(game, x, y))}
      else
        {:noreply, assign(socket, :game, Game.reveal_tile(game, x, y))}
      end
    else
      _ -> {:noreply, socket}
    end
  end

  @impl Phoenix.LiveView
  def handle_event("enable_flag_placing", %{"key" => "Shift"}, socket) do
    {:noreply, assign(socket, :placing_flags, true)}
  end

  @impl Phoenix.LiveView
  def handle_event("disable_flag_placing", %{"key" => "Shift"}, socket) do
    {:noreply, assign(socket, :placing_flags, false)}
  end

  @impl Phoenix.LiveView
  def handle_event("restart", _params, socket) do
    {:noreply, assign(socket, :game, Game.generate_initial())}
  end

  @impl Phoenix.LiveView
  def handle_event(_event, _params, socket) do
    {:noreply, socket}
  end

  def tile_at(game, x, y) do
    Game.tile_at(game, x, y)
  end
end
