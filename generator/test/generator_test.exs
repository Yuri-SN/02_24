defmodule GeneratorTest do
  use ExUnit.Case

  describe "tests with valid input data" do
    test "generate random string with default length" do
      random_string = Generator.string()

      assert String.length(random_string) == 6
    end

    test "generate random string with 10 chars" do
      random_string = Generator.string(10)

      assert String.length(random_string) == 10
    end
  end

  describe "tests with invalid input data" do
    test "try generate random string with 0 as length param" do
      assert_raise FunctionClauseError, fn ->
        Generator.string(0)
      end
    end

    test "try generate random string with -12 as length param" do
      assert_raise FunctionClauseError, fn ->
        Generator.string(-12)
      end
    end

    test "try to generate random string with string as length param" do
      assert_raise FunctionClauseError, fn ->
        Generator.string("20")
      end
    end

    test "try to generate random string with float as length param" do
      assert_raise FunctionClauseError, fn ->
        Generator.string(2.1)
      end
    end
  end
end
