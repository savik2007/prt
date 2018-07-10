defmodule PRT.Tasks do
  @moduledoc false

  alias Ecto.Repo
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :prt_task)
  end

  def init(_opts) do
    {:ok,[]}
  end

  def handle_call({:wrap_list, list_values, list_keys}, _from, state) do
    mes = list_composition(list_values, list_keys)
    {:reply, mes, state}
  end

  def handle_call({:github_repo_info, owner_repo}, _from, state) do
    host_url = "https://api.github.com/repos"
    mes =
      "#{host_url}/#{owner_repo}"
      |> get()
      |> check_repos()
    {:reply, mes, state}
  end

  def handle_call(:ecto_query, _from, state) do
    mes = select_users_info()
    {:reply, mes, state}
  end

  #  ------------------------------------------------------------------

  def list_composition(list_values, list_keys) do
    list_composition(list_values, list_keys, [])
  end

  defp list_composition([], _, acc), do: acc
  defp list_composition([value | list_values], [h, h2 | _] = list_keys, acc) do
    [first_key, second_key] = Enum.map([h, h2], fn(x) -> String.to_existing_atom(x) end)
    new_list = for n <- list_keys, do: Keyword.new([{first_key, value},{second_key, n}])
    list_composition(list_values, list_keys, new_list ++ acc)
  end

  #  ------------------------------------------------------------------

  defp get(url) do
    case HTTPoison.get(url) do
      {:ok, response = %HTTPoison.Response{status_code: 200}} ->
        response.body
        |> Poison.decode()
      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "cannot open #{url}: invalid status code #{code}"}
      {:error, reason} ->
        {:error, "cannot open #{url}: #{inspect reason}"}
    end
  end

  defp check_repos({:ok, resp_body}) do
    case Map.get(resp_body, "private", true) do
      false -> {:ok, Map.get(resp_body, "stargazers_count", 0)}
      _-> {:error, "repo is private"}
    end
  end
  defp check_repos(mes), do: mes

  #  ------------------------------------------------------------------

  defp select_users_info() do
    qeary = from user in users,
    join: post in assoc(user, :post),
    group_by: post.kind
    select: %{:user_id => user.id, String.to_existing_atom (post.kind ++ "_count") => count(post.id)}

    qeary
    |> Repo.all()
  end

  #  ------------------------------------------------------------------

  def wrap_list(list_values, list_keys) do
    GenServer.call(:prt_task, {:wrap_list, list_values, list_keys})
  end

  def repo_info(owner_repo) do
    GenServer.call(:prt_task, {:github_repo_info, owner_repo})
  end

end