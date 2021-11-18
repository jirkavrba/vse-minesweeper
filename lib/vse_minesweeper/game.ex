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

  @spec reveal_tile(t(), integer(), integer()) :: t()
  def reveal_tile(%__MODULE__{mines: mines} = game, x, y) do
    location = %Location{x: x, y: y}

    if location in mines do
      game_over(game)
    else
      reveal_number_tile(game, location)
    end
  end

  @spec game_over(t()) :: t()
  defp game_over(%__MODULE__{} = game) do
    game
    |> Map.put(:game_over, true)
    |> Map.put(:won, false)
  end

  @spec reveal_number_tile(t(), Location.t()) :: t()
  defp reveal_number_tile(%__MODULE__{tiles: tiles, revealed_tiles: revealed_tiles} = game, %Location{x: x, y: y} = location) do
    # TODO: Implement revealing sequence of tiles and checking for win conditions
    game
    |> Map.put(:revealed_tiles, revealed_tiles ++ [location])
  end
end
