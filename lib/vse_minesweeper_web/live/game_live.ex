defmodule VseMinesweeperWeb.GameLive do
  use VseMinesweeperWeb, :live_view

  alias VseMinesweeper.Game
  alias VseMinesweeper.Game.Location

  @impl true
  def mount(_params, _session, socket) do
    socket = socket
    |> assign(:game, Game.generate())
    |> assign(:flags_placed, [])
    |> assign(:tiles_revealed, [])
    |> assign(:game_over, false)

    {:ok, socket}
  end

  @impl true
  def handle_event("reveal", %{"x" => x, "y" => y}, socket) do
    with {x, _} <- Integer.parse(x),
         {y, _} <- Integer.parse(y) do
      socket = socket
      |> assign(:tiles_revealed, [%Location{x: x, y: y}])

      IO.inspect(socket.assigns)

      {:noreply, socket}
    end

    IO.inspect(socket.assigns)

    {:noreply, socket}
  end
end
