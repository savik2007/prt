defmodule PRT.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: :supervidor_prt)
  end

  def init(_) do
    children = [
      worker(PRT.Tasks, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end