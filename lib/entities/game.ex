defmodule Games.Entities.Game do
  @enforce_keys [:name, :year, :producer]
  defstruct [:id, :name, :year, :producer]
end
