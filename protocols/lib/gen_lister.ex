defmodule GenLister do
  @callback convert_to_list(term) :: {:ok, []}
end
