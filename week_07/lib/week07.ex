defmodule Week07 do
  @moduledoc """
  Documentation for `Week07`.
  """

  @behaviour Converter

  @impl Converter
  def to_list(term) do
    Lister.to_list(term)
  end
end
