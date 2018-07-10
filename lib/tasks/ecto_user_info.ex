defmodule PRT.EctoUserInfo do
  @moduledoc false

  import Ecto.Query, only: [from: 2]
  alias PRT.Repo
  alias PRT.Post

  @spec select_users_info() :: [PRT.user_info()]
  def select_users_info() do
    qeary =
      from pt in Post,
           join: user in assoc(pt, :user),
           group_by: pt.kind,
           group_by: user.id,
           order_by: user.id,
           select: %{:user_id => user.id, pt.kind => count(pt.id)}
    qeary
    |> Repo.all()
    |> Enum.chunk_by(&(&1.user_id))
    |> Enum.map(fn(x) -> Enum.reduce(x, %{}, fn(x, acc) -> Map.merge(x, acc) end) end)
    |> Enum.map(fn(x) ->
      %{:user_id => x.user_id,
        :articles_count   => Map.get(x, "article"),
        :links_count      => Map.get(x, "link"),
        :promotions_count => Map.get(x, "promotion"),
        :images_count     => Map.get(x, "image")}
    end)
  end
end
