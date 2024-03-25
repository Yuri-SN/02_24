defmodule Week07Test do
  use ExUnit.Case

  test "convert string to list" do
    assert Week07.to_list("123") == ["1", "2", "3"]
    assert Week07.to_list(<<0::1>>) == [0]
    assert Week07.to_list(14) == ["1", "4"]
  end
end
