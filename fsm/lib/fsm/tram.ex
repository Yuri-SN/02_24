defmodule Fsm.Tram do
  @moduledoc """
  Модуль, реализующий конечный автомат трамвая

  Возможные статусы:
  - :idle - в депо
  - :moving - движение по маршруту
  - :stopped - стоит на остановке
  """

  use GenServer

  @max_passengers 20
  @initial_state %{tram_num: "", passengers: 0, doors_opened: false, status: :idle}

  # public API

  @doc """
  Создаёт трамвай с указанным маршрутом
  """
  def start_link(tram_num) do
    GenServer.start_link(__MODULE__, %{@initial_state | tram_num: tram_num}, name: __MODULE__)
  end

  def max_passengers, do: @max_passengers

  @doc """
  Посылает трамваю команду

  Доступные команды:
  - :start - начало движения
  - :stop - остановиться
  - :change_passengers - погрузка / выгрузка пассажиров
  - :to_depot - движение в депо
  """
  def send_command(command) do
    GenServer.call(__MODULE__, {:command, command})
  end

  def status, do: GenServer.call(__MODULE__, :status)

  # callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  # sync handlers

  @impl true
  def handle_call({:command, command}, _from, state) do
    {new_state, message} = handle_command(command, state)
    {:reply, message, new_state}
  end

  @impl true
  def handle_call(:status, _from, state) do
    {:reply, state, state}
  end

  # internal functions

  # from :idle
  defp handle_command(:start, %{status: :idle} = state),
    do: {%{state | status: :moving}, "tram #{state.tram_num} started moving"}

  defp handle_command(:to_depot, %{status: :idle} = state),
    do: {state, "already in depot"}

  defp handle_command({:change_passengers, _num}, %{status: :idle} = state),
    do: {state, "can't change passengers: tram in depot"}

  defp handle_command(:stop, %{status: :idle} = state),
    do: {state, "can't stop: tram in depot"}

  # from :moving
  defp handle_command(:stop, %{status: :moving} = state),
    do: {%{state | status: :stopped, doors_opened: true}, "tram #{state.tram_num} stopped"}

  defp handle_command(:start, %{status: :moving} = state),
    do: {state, "tram #{state.tram_num} already moving"}

  defp handle_command({:change_passengers, _num}, %{status: :moving} = state),
    do: {state, "can't change passengers: tram moving"}

  defp handle_command(:empty_tram, %{status: :moving} = state),
    do: {state, "can't empty tram: tram is moving"}

  defp handle_command(:to_depot, %{status: :moving} = state),
    do: {state, "can't move to depot: on route"}

  # from :stopped
  defp handle_command(:start, %{status: :stopped} = state),
    do: {%{state | status: :moving, doors_opened: false}, "tram #{state.tram_num} started moving"}

  defp handle_command(:stop, %{status: :stopped} = state),
    do: {state, "tram #{state.tram_num} already stopped"}

  defp handle_command({:change_passengers, num}, %{status: :stopped} = state),
    do: {%{state | passengers: num}, "passengers changed"}

  defp handle_command(:empty_tram, %{status: :stopped} = state),
    do: {%{state | passengers: 0}, "tram is empty"}

  defp handle_command(:to_depot, %{status: :stopped} = state) when state.passengers == 0,
    do: {%{state | status: :idle, doors_opened: false}, "moving to depot and stop"}

  defp handle_command(:to_depot, %{status: :stopped} = state) when state.passengers > 0,
    do: {state, "can't move to depot: tram is not empty"}

  # any other variants
  defp handle_command(_, state), do: {state, "command not allowed"}
end
