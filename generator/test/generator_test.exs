defmodule GeneratorTest do
  use ExUnit.Case

  test "generate random string with default length" do
    {result, response} = Generator.string()

    assert result == :ok
    assert String.length(response) == 6
  end

  test "generate random string with 10 chars" do
    {result, response} = Generator.string(10)

    assert result == :ok
    assert String.length(response) == 10
  end

  test "try generate random string with 0 as length param" do
    {result, response} = Generator.string(0)

    assert result == :error
    assert response == "parameter must be positive integer"
  end

  test "try generate random string with -12 as length param" do
    {result, response} = Generator.string(-12)

    assert result == :error
    assert response == "parameter must be positive integer"
  end

  test "try to generate random string with string as length param" do
    {result, response} = Generator.string("20")

    assert result == :error
    assert response == "parameter must be positive integer"
  end

  test "try to generate random string with float as length param" do
    {result, response} = Generator.string(2.1)

    assert result == :error
    assert response == "parameter must be positive integer"
  end
end
