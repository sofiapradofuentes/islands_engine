defmodule IslandEngine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Registry, keys: :unique, name: Registry.Game},
      IslandsEngine.GameSupervisor
      # Starts a worker by calling: IslandEngine.Worker.start_link(arg)
      # {IslandEngine.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    :ets.new(:game_state, [:public, :named_table])
    opts = [strategy: :one_for_one, name: IslandEngine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
