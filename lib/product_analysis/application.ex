defmodule ProductAnalysis.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProductAnalysisWeb.Telemetry,
      ProductAnalysis.Repo,
      {DNSCluster, query: Application.get_env(:product_analysis, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProductAnalysis.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProductAnalysis.Finch},
      # Start a worker by calling: ProductAnalysis.Worker.start_link(arg)
      # {ProductAnalysis.Worker, arg},
      # Start to serve requests, typically the last entry
      ProductAnalysisWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProductAnalysis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProductAnalysisWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
