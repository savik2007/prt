defmodule PRTTest do
  use ExUnit.Case

  alias  PRT.EctoUserInfo
  import PRT.Factory

  setup do
    bypass = Bypass.open()
    update_api_url(bypass)

    on_exit(fn ->
      Bypass.down(bypass)
    end)

    {:ok, bypass: bypass}
  end

  defp update_api_url(bypass) do
    config = Application.get_env(:prt, :github_api, :github_api_repos_url)
    new_config =
      Keyword.put(
        config,
        :github_api_repos_url,
        "http://localhost:#{bypass.port}"
      )
    Application.put_env(:prt, :github_api, new_config)
  end

  test "wrap list test" do
    assert PRT.wrap_list([1, 2], ["a", "b", "c"]) == [[a: 2, b: "a"], [a: 2, b: "b"], [a: 2, b: "c"], [a: 1, b: "a"], [a: 1, b: "b"], [a: 1, b: "c"]]
    assert PRT.wrap_list({1, 2}, ["a", "b", "c"]) == {:error, "Incorrect params in request"}
  end

  test "select data from DB" do
    post = insert(:post)
    [select_article|_] = EctoUserInfo.select_users_info()

    assert 1 == select_article.articles_count
  end

  test "github user info pub", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      assert "/rails" == conn.request_path
      Plug.Conn.resp(conn, 200, "{\"id\":8514,\"private\":false,\"stargazers_count\":40681}")
    end)
    assert  {:ok, 40681} == PRT.github_stars("rails")
  end

  test "github user info priv", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      assert "/rails" == conn.request_path
      Plug.Conn.resp(conn, 200, "{\"id\":8514,\"private\":true,\"stargazers_count\":40681}")
    end)
    assert {:error, "repo is private"} == PRT.github_stars("rails")
  end
end
