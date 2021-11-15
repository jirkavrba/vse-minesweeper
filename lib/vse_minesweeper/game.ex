defmodule VseMinesweeper.Game do
  @type t :: %__MODULE__{
          tiles: list(Tile.t()),
          mines: list(Location.t())
        }

  @enforce_keys [:tiles, :mines, :flags_placed]

  defstruct [:tiles, :mines, :flags_placed]

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

  @spec generate(integer()) :: t()
  def generate(number_of_mines) do
   # TODO: Implement level generator
  end
end
