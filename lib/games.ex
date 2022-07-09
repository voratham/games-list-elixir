defmodule Games do
  alias Games.Entities.Game

  @db_path "games.bin"

  def all, do: load_or_create()

  def get_by_id(id) do
    all()
    |> Enum.find(fn game -> game.id == id end)
  end

  def add(%Game{id: nil} = game) do
    last_id = get_last_id()

    new_game_with_id = struct(game, %{id: last_id + 1})

    new_list = [new_game_with_id | all()]
    File.write!(@db_path, :erlang.term_to_binary(new_list))
    new_list
  end

  defp get_last_id do
    if all() == [] do
      0
    else
      all()
      |> Enum.max_by(fn game -> game.id end)
      |> Map.get(:id)
    end
  end

  defp load_or_create do
    if File.exists?(@db_path) do
      :erlang.binary_to_term(File.read!(@db_path))
    else
      starting_value = []
      File.write!(@db_path, :erlang.term_to_binary(starting_value))
      starting_value
    end
  end
end
