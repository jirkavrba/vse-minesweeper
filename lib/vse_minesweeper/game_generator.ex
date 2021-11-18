defmodule VseMinesweeper.GameGenerator do
  alias VseMinesweeper.Game
  alias VseMinesweeper.Game.Location
  alias VseMinesweeper.Game.Tile

  @spec generate_empty_game(integer(), integer()) :: Game.t()
  def generate_empty_game(width, height) do
    locations = for y <- 0..(height - 1), x <- 0..(width - 1), do: %Location{x: x, y: y}
    tiles = Enum.map(locations, fn location -> %Tile{location: location, number: 0} end)

    %Game{
      width: width,
      height: height,
      tiles: tiles,
      mines: []
    }
  end

  @spec generate_new_game(integer(), integer(), integer(), Location.t()) :: Game.t()
  def generate_new_game(width, height, number_of_mines, start) do
    locations = for y <- 0..(height - 1), x <- 0..(width - 1), do: %Location{x: x, y: y}

    # tiles around the start position are excluded so no mines can be generated there
    mines = select_mines(number_of_mines, locations -- neighbours(start), [])
    tiles = compute_tiles(locations, mines)

    %Game{
      width: width,
      height: height,
      tiles: tiles,
      mines: mines
    }
  end

  @spec select_mines(integer(), list(Location.t()), list(Location.t())) :: list(Location.t())
  defp select_mines(0, _locations, mines), do: mines

  defp select_mines(remaining, locations, mines) do
    random = Enum.random(locations)

    cond do
      random in mines -> select_mines(remaining, locations, mines)
      true -> select_mines(remaining - 1, locations, mines ++ [random])
    end
  end

  @spec compute_tiles(list(Location.t()), list(Location.t())) :: list(Tile.t())
  defp compute_tiles(locations, mines) do
    locations
    |> Enum.map(fn location -> compute_tile(location, mines) end)
  end

  @spec compute_tile(Location.t(), list(Location.t())) :: Tile.t()
  defp compute_tile(location, mines) do
    number = Enum.count(neighbours(location), fn tile -> tile in mines end)

    %Tile{
      location: location,
      number: number
    }
  end

  @spec neighbours(Location.t()) :: list(Location.t())
  defp neighbours(location)  do
    for x <- -1..1, y <- -1..1 do
      %Location{x: location.x + x, y: location.y + y}
    end
  end
end
