defprotocol Lister do
  def to_list(input)
end

defimpl Lister, for: Atom do
  def to_list(atom) do
    atom
    |> to_string()
    |> String.graphemes()
  end
end

defimpl Lister, for: BitString do
  def to_list(str) do
    str
    |> String.graphemes()
  end
end

defimpl Lister, for: Float do
  def to_list(num) do
    num
    |> to_string()
    |> String.graphemes()
  end
end

defimpl Lister, for: Integer do
  def to_list(num) do
    num
    |> to_string()
    |> String.graphemes()
  end
end

defimpl Lister, for: List do
  def to_list(list) do
    list
  end
end

defimpl Lister, for: Map do
  def to_list(map) do
    map
    |> Map.to_list()
  end
end

defimpl Lister, for: Tuple do
  def to_list(tuple) do
    tuple
    |> Tuple.to_list()
  end
end
