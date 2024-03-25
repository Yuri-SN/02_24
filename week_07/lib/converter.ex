defmodule Converter do
  @callback to_list(term) :: {:ok, []} | {:error, <<>>}
end
