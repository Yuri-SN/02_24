defmodule CalculatorTest do
  use ExUnit.Case

  doctest Calculator

  describe "test add function" do
    test "try to add with incorrect first param" do
      assert Calculator.add("1", 2) == "error: incorrect input data"
    end

    test "try to add with incorrect second param" do
      assert Calculator.add(3, "4") == "error: incorrect input data"
    end
  end

  describe "test subtract function" do
    test "try to add with incorrect first param" do
      assert Calculator.subtract("10", 25) == "error: incorrect input data"
    end

    test "try to add with incorrect second param" do
      assert Calculator.subtract(39, "42") == "error: incorrect input data"
    end
  end

  describe "test multiply function" do
    test "try to add with incorrect first param" do
      assert Calculator.multiply("12", 22) == "error: incorrect input data"
    end

    test "try to add with incorrect second param" do
      assert Calculator.multiply(3, "4") == "error: incorrect input data"
    end
  end

  describe "test divide function" do
    test "try to add with incorrect first param" do
      assert Calculator.divide("122", 2) == "error: incorrect input data"
    end

    test "try to add with incorrect second param" do
      assert Calculator.divide(9, "3") == "error: incorrect input data"
    end
  end
end
