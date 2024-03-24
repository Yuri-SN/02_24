defmodule Protocols do
  @moduledoc """
  Documentation for `Protocols`.
  """

  @behaviour GenLister

  @impl GenLister
  def convert_to_list(term) do
    list = Lister.to_list(term)

    {:ok, list}
  end
end
