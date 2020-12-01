defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.Attack
  alias ExMon.Game.Actions.Heal

  def fetch_move(move)do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end

  def attack(move) do
    case Game.turn() do
      :computer -> Attack.attack_opponent(:player,move)
      :player -> Attack.attack_opponent(:computer,move)
    end
  end

  def heal() do
    case Game.turn() do
      :computer -> Heal.heal_life(:computer)
      :player -> Heal.heal_life(:player)
    end
  end
end
