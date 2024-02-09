defmodule Calculator do
  @moduledoc """
  Модуль реализует базовые операции над двумя числами
  """

  @doc """
  Складывает два числа
  ## Examples
    iex> Calculator.add(7, 9)
    16
    iex> Calculator.add(700, 95)
    795
  """
  @spec add(number(), number()) :: number()
  def add(a, b) when is_number(a) and is_number(b) do
    a + b
  end

  def add(_a, _b) do
    "error: incorrect input data"
  end

  @doc """
  Вычитает из первого числа второе
  ## Examples
    iex> Calculator.subtract(7, 9)
    -2
    iex> Calculator.subtract(700, 78)
    622
  """
  @spec subtract(number(), number()) :: number()
  def subtract(a, b) when is_number(a) and is_number(b) do
    a - b
  end

  def subtract(_a, _b) do
    "error: incorrect input data"
  end

  @doc """
  Умножает два числа
  ## Examples
    iex> Calculator.multiply(7, 9)
    63
    iex> Calculator.multiply(100, 78)
    7800
  """
  @spec multiply(number(), number()) :: number()
  def multiply(a, b) when is_number(a) and is_number(b) do
    a * b
  end

  def multiply(_a, _b) do
    "error: incorrect input data"
  end

  @doc """
  Делит первое число на второе
  ## Examples
    iex> Calculator.divide(18, 3)
    6.0
    iex> Calculator.divide(3, 7)
    0.42857142857142855
    iex> Calculator.divide(100, 9)
    11.11111111111111
  """
  @spec divide(number(), number()) :: float()
  def divide(a, b) when is_number(a) and is_number(b) do
    a / b
  end

  def divide(_a, _b) do
    "error: incorrect input data"
  end
end
