defmodule Processes.Echo do
  @moduledoc """
  Модуль работающий как эхо сервер.
  Получает сообщение :ping и высылает обратно {:pong, node()}.
  """

  use GenServer

  require Logger

  def start() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :echo_server})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:ping, _from, state) do
    {:reply, {:pong, node()}, state}
  end
end
