defmodule ProtocolsTest do
  use ExUnit.Case

  test "convert string to list" do
    assert Protocols.convert_to_list("123") == {:ok, ["1", "2", "3"]}
  end
end
