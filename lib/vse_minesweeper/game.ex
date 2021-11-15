defmodule VseMinesweeper.Game do
  alias VseMinesweeper.GameGenerator

  @type t :: %__MODULE__{
          width: integer(),
          height: integer(),
          tiles: list(Tile.t()),
          mines: list(Location.t()),
        }

  @enforce_keys [:width, :height, :tiles, :mines]

  defstruct [:width, :height, :tiles, :mines]

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

  @number_of_mines 30

  @spec generate() :: t()
  def generate() do
    GameGenerator.generate_new_game(@width, @height, @number_of_mines)
  end
end
