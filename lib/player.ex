defmodule ExMon.Player do
  # boa pratica por em ordem alfabetica
  @required_keys [:life, :moves, :name]
  @max_life 100

  # atributos obrigatorios de serem preenchidos na construcao da struct
  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name, move_avg, move_heal, move_rand) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rnd: move_rand
      },
      name: name
    }
  end
end
