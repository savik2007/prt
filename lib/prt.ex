defmodule PRT do
  @moduledoc """
  Documentation for PRT.
  """

  alias PRT.Tasks

  @doc """

  """

  def start(_type, _args) do
    PRT.Supervisor.start_link
  end

  def wrap_list(list_values, list_keys), do: Tasks.wrap_list(list_values, list_keys)
  def github_stars(owner_repo), do: Tasks.repo_info(owner_repo)
  def ecto_query(), do: Tasks.ecto_query()
end
