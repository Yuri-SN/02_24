defmodule Processes.Echo do
  @moduledoc """
  Модуль работающий как эхо сервер.
  Получает синхронное сообщение :ping и высылает обратно {:pong, node()}.
  """

  use GenServer

  require Logger

  @doc "Запускает процесс с глобальным именем `:echo_server`"
  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: {:global, :echo_server})
  end

  @impl true
  @doc false
  def init(state) do
    {:ok, state}
  end

  @impl true
  @doc false
  def handle_call(:ping, _from, state) do
    {:reply, {:pong, node()}, state}
  end
end
