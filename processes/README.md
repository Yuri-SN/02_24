# Processes

## Node 1

```elixir
iex --sname node1@localhost -S mix

{:ok, p} = Processes.Echo.start_link()
```

## Node 2

```elixir
iex --sname node2@localhost -S mix

Node.connect(:node1@localhost)
Node.list([:this, :visible])

GenServer.call({:global, :echo_server}, :ping)
```
