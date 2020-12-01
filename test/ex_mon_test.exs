defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_return = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "tarcisio"
      }

      assert ExMon.create_player("tarcisio", :soco, :cura, :chute) == expected_return
    end
  end

  describe "start_game/1" do
    test "when the game starts, print a message" do
      player = Player.build("tarcisio", :soco, :cura, :chut)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "\n===========Jogo Inicializado===================\n\n%{\n "
      assert messages =~ "moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chut}"
    end
  end

  describe "make_move/1" do
    setup %{} do
      player = ExMon.create_player("tarcisio", :soco, :cura, :chute)
      # ExMon.start_game(player) se deixar esse comando fora do Capture_io, vai poluir os testes

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid and the computer makes a move" do
      message =
        capture_io(fn ->
          assert ExMon.make_move(:chute) == :ok
        end)

      assert message =~ "\nThe Player attacked the computer"
      assert message =~ "=====It's player turn.====="
      assert message =~ "status: :continue"
    end

    test "when the move is invalid" do
      message =
        capture_io(fn ->
          assert ExMon.make_move(:moviment) == :ok
        end)

      assert message =~ "=Invalid Move moviment=="
    end
  end
end
