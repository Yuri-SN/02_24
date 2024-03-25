defmodule ListerTest do
  use ExUnit.Case

  test "for Atom" do
    assert Lister.to_list(:t_a) == ["t", "_", "a"]
  end

  test "for BitString" do
    assert Lister.to_list("s_12") == ["s", "_", "1", "2"]
    assert Lister.to_list("A") == ["A"]
    assert Lister.to_list(<<0::1>>) == [0]
    assert Lister.to_list(<<0::1, 1::1, 0::1>>) == [0, 1, 0]
  end

  test "for Float" do
    assert Lister.to_list(0.0) == ["0", ".", "0"]
    assert Lister.to_list(28.5) == ["2", "8", ".", "5"]
  end

  test "for Integer" do
    assert Lister.to_list(-25) == ["-", "2", "5"]
    assert Lister.to_list(0) == ["0"]
    assert Lister.to_list(283) == ["2", "8", "3"]
  end

  test "for List" do
    assert Lister.to_list([1, :a2, "3"]) == [1, :a2, "3"]
  end

  test "for Map" do
    assert Lister.to_list(%{}) == []
    assert Lister.to_list(%{a: 1, b: 2}) == [{:a, 1}, {:b, 2}]
  end

  test "for Tuple" do
    assert Lister.to_list({}) == []
    assert Lister.to_list({:a, 1, :b, 2}) == [:a, 1, :b, 2]
  end
end
