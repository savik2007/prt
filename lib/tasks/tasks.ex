defmodule PRT.Tasks do
  @moduledoc false
  use GenServer

  alias PRT.ElixirComposition
  alias PRT.EctoUserInfo
  alias PRT.GitHubRepoInfo


  @type wrap_list_request()        :: {:wrap_list, PRT.list_values(), PRT.list_keys()}
  @type github_repo_info_request() :: {:github_repo_info, PRT.owner_repo()}
  @type ecto_query_request()       :: :ecto_query
  @type state()                    :: []
  @type message()                  :: [PRT.wrap_list()] | [PRT.user_info()] | PRT.repo_stars() | PRT.error()
  @type handle_call_resp()         :: {:reply, message(), state()}

  @spec start_link() :: result when
         result: {:ok, pid()}

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :prt_task)
  end

  @spec init(state()) :: {:ok, state()}

  def init(_opts) do
    {:ok,[]}
  end

  @spec handle_call(request, from, state()) :: handle_call_resp() when
    request: wrap_list_request() | github_repo_info_request() | ecto_query_request(),
    from: {pid(), term()}

  def handle_call({:wrap_list, list_values, list_keys}, _from, state) do
    mes = ElixirComposition.list_composition(list_values, list_keys)
    {:reply, mes, state}
  end

  def handle_call({:github_repo_info, owner_repo}, _from, state) do
    mes = GitHubRepoInfo.repo_info(owner_repo)
    {:reply, mes, state}
  end

  def handle_call(:ecto_query, _from, state) do
    mes = EctoUserInfo.select_users_info()
    {:reply, mes, state}
  end

  #  ------------------------------------------------------------------

  @spec wrap_list(PRT.list_values(), PRT.list_keys()) :: [PRT.wrap_list()]
  def wrap_list(list_values, list_keys) do
    GenServer.call(:prt_task, {:wrap_list, list_values, list_keys})
  end

  @spec repo_info(PRT.owner_repo()) :: PRT.repo_stars() | PRT.error()
  def repo_info(owner_repo) do
    GenServer.call(:prt_task, {:github_repo_info, owner_repo})
  end

  @spec ecto_query() :: [PRT.user_info()]
  def ecto_query() do
    GenServer.call(:prt_task, :ecto_query)
  end

end