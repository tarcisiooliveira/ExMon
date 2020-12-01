defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Status, Actions}

  @computername "Robotinik"
  @moves [:move_avg, :move_heal, :move_rnd]

  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end

  def start_game(player) do
    @computername
    |> create_player(:punch, :heal, :kick)
    |> Game.start(player)

    Status.print_status_game(Game.info())
  end

  def make_move(move) do
    move
    |>Actions.fetch_movie()
    |>do_move()

    computer_move(Game.info())
  end

  def do_move({:error, move}), do: Status.invalid_move(move)
  def do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_status_game(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    {:ok, Enum.random(@moves)}
    |> do_move()
  end

  defp computer_move(_), do: :ok
end
