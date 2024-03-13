defmodule FirstPhxApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FirstPhxAppWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:first_phx_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FirstPhxApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FirstPhxApp.Finch},
      # Start a worker by calling: FirstPhxApp.Worker.start_link(arg)
      # {FirstPhxApp.Worker, arg},
      # Start to serve requests, typically the last entry
      FirstPhxAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FirstPhxApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FirstPhxAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
