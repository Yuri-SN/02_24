defmodule Generator do
  @moduledoc """
  Модуль для генерации случайных данных
  """

  @chars String.graphemes("abcdefghijklmnopqrstuvwxyz")

  @doc """
  Создаёт строку указанной длины из строчных букв английского алфавита.
  """
  def string(length \\ 6) when is_integer(length) and length > 0 do
    1..length
    |> Enum.map_join("", fn _i -> Enum.random(@chars) end)
  end
end
