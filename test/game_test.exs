defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Tarcisio", :soco, :cura, :chute)
      computer = Player.build("Robotinik", :punch, :heal, :kick)
      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return of game info" do
      player = Player.build("Tarcisio", :soco, :cura, :chute)
      computer = Player.build("Robotinik", :punch, :heal, :kick)
      Game.start(computer, player)

      expected_response = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Tarcisio"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "update game info" do
      player = Player.build("Tarcisio", :soco, :cura, :chute)
      computer = Player.build("Robotinik", :punch, :heal, :kick)
      Game.start(computer, player)

      expected_response = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Tarcisio"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response

      new_state = %{
        computer: %ExMon.Player{
          life: 80,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 17,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Tarcisio"
        },
        status: :continue,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | status: :continue, turn: :computer}

      assert Game.info() == expected_response
    end
  end

  describe "player/1" do
    test "get Player info" do
      player = Player.build("Tarcisio", :soco, :cura, :chute)
      computer = Player.build("Robotinik", :punch, :heal, :kick)
      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Tarcisio"
      }

      assert Game.player() == expected_response
    end
  end

  describe "turn/1" do
    test "get turn info" do
      player = Player.build("Tarcisio", :soco, :cura, :chute)
      computer = Player.build("Robotinik", :punch, :heal, :kick)
      Game.start(computer, player)

      expected_response = :player

      assert Game.turn() == expected_response
    end
  end

  describe "fetch/1" do
    test "get fetch info" do
      player = Player.build("Tarcisio", :soco, :cura, :chute)
      computer = Player.build("Robotinik", :punch, :heal, :kick)
      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Tarcisio"
      }

      assert Game.fetch_player(:player) == expected_response
    end
  end
end
