defmodule VseMinesweeper.Game do
  alias VseMinesweeper.GameGenerator

  @type t :: %__MODULE__{
          width: integer(),
          height: integer(),
          tiles: list(Tile.t()),
          mines: list(Location.t()),
          revealed_tiles: list(Location.t()),
          flags_placed: list(Location.t()),
          game_over: boolean(),
          won: boolean()
        }

  @enforce_keys [:width, :height, :tiles, :mines]

  defstruct [
    :width,
    :height,
    :tiles,
    :mines,
    revealed_tiles: [],
    flags_placed: [],
    game_over: false,
    won: false
  ]

  defmodule Location do
    @type t :: %__MODULE__{
            x: integer(),
            y: integer()
          }

    @enforce_keys [:x, :y]

    defstruct [:x, :y]

    @spec neighbours(Location.t()) :: list(Location.t())
    def neighbours(location)  do
      for x <- -1..1, y <- -1..1 do
        %Location{x: location.x + x, y: location.y + y}
      end
    end
  end

  defmodule Tile do
    @type t :: %__MODULE__{
            location: Location.t(),
            number: integer()
          }

    @enforce_keys [:location, :number]

    defstruct [:location, :number]

    @spec new(integer(), integer()) :: t()
    def new(x, y) do
      %__MODULE__{
        location: %Location{x: x, y: y},
        number: 0
      }
    end
  end

  @width 16

  @height 8

  @number_of_mines 16

  @spec generate(integer(), integer()) :: t()
  def generate(x, y) do
    GameGenerator.generate_new_game(
      @width,
      @height,
      @number_of_mines,
      %Location{x: x, y: y}
    )
  end

  def generate_initial() do
    GameGenerator.generate_empty_game(@width, @height)
  end

  def tile_at(%__MODULE__{tiles: tiles, width: width}, x, y) do
    Enum.at(tiles, y * width + x)
  end

  def contains_tile(%__MODULE__{width: width, height: height}, x, y) do
    x in 0..(width - 1) and y in 0..(height - 1)
  end

  @spec reveal_tile(t(), integer(), integer()) :: t()
  def reveal_tile(%__MODULE__{mines: mines, revealed_tiles: revealed_tiles} = game, x, y) do
    location = %Location{x: x, y: y}

    cond do
      location in mines                                            -> game_over(game)
      contains_tile(game, x, y) and tile_at(game, x, y).number > 0 -> reveal_number_tile(game, location)
      contains_tile(game, x, y) and location not in revealed_tiles ->
        Enum.reduce(
          Location.neighbours(location),
          reveal_number_tile(game, location),
          fn %Location{x: x, y: y}, game -> reveal_tile(game, x, y) end
        )

      true -> game
    end
  end

  @spec game_over(t()) :: t()
  defp game_over(%__MODULE__{} = game) do
    game
    |> Map.put(:game_over, true)
    |> Map.put(:won, false)
  end

  @spec reveal_number_tile(t(), Location.t()) :: t()
  defp reveal_number_tile(%__MODULE__{revealed_tiles: revealed_tiles} = game, location) do
    Map.put(game, :revealed_tiles, revealed_tiles ++ [location])
  end
end
