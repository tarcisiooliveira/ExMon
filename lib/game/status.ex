defmodule ExMon.Game.Status do

  def print_status_game(%{status: :started} = info) do
    IO.puts("\n===========Jogo Inicializado===================\n")
    IO.inspect(info)
    IO.puts("------------------------------------------------")
  end


  def print_status_game(%{status: :continue, turn: player} = info) do
    IO.puts("\n===========It's #{player} turn.===================\n")
    IO.inspect(info)
    IO.puts("------------------------------------------------")
  end

  def print_status_game(%{status: :game_over} = info) do
    IO.puts("\n===========GAME OVER.===================\n")
    IO.inspect(info)
    IO.puts("------------------------------------------------")
  end

  def invalid_move(move), do: IO.puts("\n===========Invalid Move #{move}===================\n")

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\nThe Player attacked the computer dealing #{damage} damage \n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\nThe Player attacked the computer dealing #{damage} damage \n")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("\nThe #{player} healled itself to #{life} life \n")
  end
end
