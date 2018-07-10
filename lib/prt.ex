defmodule PRT do
  @moduledoc """
  Documentation for PRT.
  """

  alias PRT.Tasks

  @type value()       :: binary() | atom() | integer()
  @type list_values() :: [value()]
  @type key()         :: binary()
  @type list_keys()   :: [key()]
  @type wrap_list_key :: atom()
  @type wrap_list()   :: [wrap_list_key: value()]
  @type owner_repo()  :: binary()
  @type repo_stars()  :: {:ok, integer()}
  @type error()       :: {:error, binary()}
  @type user_info()   :: %{:user_id => integer(),
                           :articles_count => integer(),
                           :links_count => integer(),
                           :promotions_count => integer(),
                           :images_count => integer()}

  @doc """
    Start supervisor
  """
  @spec start(any(), any()) :: result when
          result: {:ok, pid()}

  def start(_type, _args) do
    PRT.Supervisor.start_link
  end

  @doc """
    Function that accepts two lists and returns keyword list with keys (a,b) that combines two list.
    Example:
      => wrap_lists([1, 2], ["a", "b", "c"])
      => [[a: 1, b: "a"], [a: 1, b: "b"], [a: 1, b: "c"], [a: 2, b: "a"], [a: 2, b: "b"], [a: 2, b: "c"]]
  """
  @spec wrap_list(list_values(), list_keys()) :: [wrap_list()]

  def wrap_list(list_values, list_keys), do: Tasks.wrap_list(list_values, list_keys)

  @doc """
    There is a database with table users(id, name) and posts(id, kind, text) where kind in
      ('article', 'promotion', 'link', 'image').
    Write an ecto query that returns such array of maps for all users:
  """
  @spec ecto_query() :: [user_info()]

  def ecto_query(), do: Tasks.ecto_query()

  @doc """
    Write a module with function that accepts public repo name and returns stars count for this repo.
    If repo is private it returns `{:error, "repo is private"}`
    Example:
      => Github.starts("rails/rails")
      => {:ok, 40114}
  """
  @spec github_stars(owner_repo()) :: repo_stars() | error()

  def github_stars(owner_repo), do: Tasks.repo_info(owner_repo)


end
