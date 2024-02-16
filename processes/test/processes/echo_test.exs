defmodule Processes.EchoTest do
  use ExUnit.Case

  describe "test on one node" do
    test "send :ping and get back :pong packet" do
      {:ok, pid} = Processes.Echo.start_link()

      {response, node} = GenServer.call({:global, :echo_server}, :ping)

      assert response == :pong
      assert node == node()

      GenServer.stop(pid)
    end
  end
end
