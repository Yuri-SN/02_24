defprotocol Lister do
  def to_list(input, opts \\ [])
end

defimpl Lister, for: Atom do
  def to_list(atom, _opts) do
    atom
    |> to_string()
    |> String.graphemes()
  end
end

defimpl Lister, for: BitString do
  def to_list(str, _opts) when is_binary(str) do
    str
    |> String.graphemes()
  end

  def to_list(bitstr, opts) when is_bitstring(bitstr) do
    bits = Keyword.get(opts, :bits, 1)

    for <<bit::size(^bits) <- bitstr>>, do: bit
  end
end

defimpl Lister, for: Float do
  def to_list(num, _opts) do
    num
    |> to_string()
    |> String.graphemes()
  end
end

defimpl Lister, for: Integer do
  def to_list(num, _opts) do
    num
    |> to_string()
    |> String.graphemes()
  end
end

defimpl Lister, for: List do
  def to_list(list, _opts) do
    list
  end
end

defimpl Lister, for: Map do
  def to_list(map, _opts) do
    map
    |> Map.to_list()
  end
end

defimpl Lister, for: Tuple do
  def to_list(tuple, _opts) do
    tuple
    |> Tuple.to_list()
  end
end
