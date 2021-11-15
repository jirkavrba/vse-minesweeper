defmodule VseMinesweeper.GameGenerator do
  alias VseMinesweeper.Game
  alias VseMinesweeper.Game.Location
  alias VseMinesweeper.Game.Tile

  @spec generate_new_game(integer(), integer(), integer()) :: Game.t()
  def generate_new_game(width, height, number_of_mines) do
    locations = for x <- 0..(width - 1), y <- 0..(height - 1), do: %Location{x: x, y: y}

    mines = select_mines(number_of_mines, locations, [])
    tiles = compute_tiles(locations, mines)

    %Game{
      width: width,
      height: height,
      tiles: tiles,
      mines: mines,
      flags_placed: []
    }
  end

  @spec select_mines(integer(), list(Location.t()), list(Location.t())) :: list(Location.t())
  defp select_mines(0, _locations, mines), do: mines
  defp select_mines(remaining, locations, mines) do
    random = Enum.random(locations)

    cond do
      random in mines -> select_mines(remaining, locations, mines)
      true            -> select_mines(remaining - 1, locations, mines ++ [random])
    end
  end

  @spec compute_tiles(list(Location.t()), list(Location.t())) :: list(Tile.t())
  defp compute_tiles(locations, mines) do
    locations
    |> Enum.map(fn location -> compute_tile(location, mines) end)
  end

  @spec compute_tile(Location.t(), list(Location.t())) :: Tile.t()
  defp compute_tile(location, mines) do
    neighbours = for x <- -1..1, y <- -1..1, do: {x, y}
    number = neighbours
    |> Enum.map(fn {x, y} -> %Location{x: location.x + x, y: location.y + y} end)
    |> Enum.count(fn tile -> tile in mines end)

    %Tile{
      location: location,
      number: number
    }
  end
end
