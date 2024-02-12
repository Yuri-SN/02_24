defmodule CalculatorTest do
  use ExUnit.Case

  doctest Calculator

  describe "test chains" do
    test "add - divide" do
      assert 5 |> Calculator.add(3) |> Calculator.divide(2) == 4.0
    end

    test "subtract - multiply" do
      assert 3 |> Calculator.subtract(4) |> Calculator.multiply(2) == -2
    end
  end
end
