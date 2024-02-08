defmodule Generator do
  @moduledoc """
  Модуль для генерации случайных данных
  """

  @chars "abcdefghijklmnopqrstuvwxyz" |> String.split("", trim: true)

  @doc """
  Создаёт строку указанной длины из строчных букв английского алфавита.
  """
  def string() do
    # по умолчанию генерируем строку из 6 символов
    string(6)
  end

  def string(length) when is_integer(length) and length > 0 do
    result =
      1..length
      |> Enum.map_join("", fn _i -> Enum.random(@chars) end)

    {:ok, result}
  end

  def string(_) do
    {:error, "parameter must be positive integer"}
  end
end
