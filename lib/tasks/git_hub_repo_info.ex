defmodule PRT.GitHubRepoInfo do
  @moduledoc false

  @type url() :: binary()
  @type success_resp() :: {:ok, map()}

  @spec repo_info(PRT.owner_repo()) :: PRT.repo_stars() | PRT.error()

  def repo_info(owner_repo) do
    host_url = Application.get_env(:prt, :github_api_repos_url)
    "#{host_url}/#{owner_repo}"
    |> get()
    |> check_repos()
  end

  @spec get(url()) :: success_resp() | PRT.error()

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

  @spec check_repos(success_resp() | PRT.error()) ::  PRT.repo_stars() | PRT.error()

  defp check_repos({:ok, resp_body}) do
    case Map.get(resp_body, "private", true) do
      false -> {:ok, Map.get(resp_body, "stargazers_count", 0)}
      _-> {:error, "repo is private"}
    end
  end
  defp check_repos(mes), do: mes

end
