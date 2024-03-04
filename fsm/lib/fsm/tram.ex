defmodule Fsm.Tram do
  @moduledoc """
  Модуль, реализующий конечный автомат трамвая

  Возможные статусы:
  - :idle - в депо
  - :moving - движение по маршруту
  - :stopped - стоит на остановке
  - :at_depot - следует в депо
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

  @doc """
  Посылает трамваю команду

  Доступные команды:
  - :start - начало движения
  - :stop - остановиться
  - :change_passengers - погрузка / выгрузка пассажиров
  - :empty_tram - выгрузить всех пассажиров
  - :at_depot - движение в депо
  """
  def send_command(command) do
    GenServer.call(__MODULE__, {:command, command})
  end

  def status(), do: GenServer.call(__MODULE__, {:status})

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
  def handle_call({:status}, _from, state) do
    {:reply, state, state}
  end

  # internal functions

  defp handle_command(command, state) do
    case state.status do
      :idle ->
        handle_idle_state(command, state)

      :stopped ->
        handle_stopped_state(command, state)

      :moving ->
        handle_moving_state(command, state)
    end
  end

  defp handle_idle_state(command, state) do
    case command do
      :start ->
        {%{state | status: :moving}, "tram #{state.tram_num} started moving"}

      :at_depot ->
        {state, "already in depot"}

      :change_passengers ->
        {state, "can't change passengers: tram in depot"}

      :stop ->
        {state, "can't stop: tram in depot"}

      _ ->
        {state, "command not allowed"}
    end
  end

  defp handle_stopped_state(command, state) do
    case command do
      :start ->
        {%{state | status: :moving, doors_opened: false}, "tram #{state.tram_num} started moving"}

      :stop ->
        {state, "tram #{state.tram_num} already stopped"}

      :change_passengers ->
        {%{state | passengers: Enum.random(1..@max_passengers)}, "passengers changed"}

      :empty_tram ->
        {%{state | passengers: 0}, "tram is empty"}

      :at_depot ->
        {%{state | status: :idle, doors_opened: false}, "moving to depot"}

      _ ->
        {state, "command not allowed"}
    end
  end

  defp handle_moving_state(command, state) do
    case command do
      :stop ->
        {%{state | status: :stopped, doors_opened: true}, "tram #{state.tram_num} stopped"}

      :start ->
        {state, "tram #{state.tram_num} already moving"}

      :change_passengers ->
        {state, "can't change passengers: tram moving"}

      :empty_tram ->
        {state, "can't empty tram: tram is moving"}

      _ ->
        {state, "command not allowed"}
    end
  end
end
