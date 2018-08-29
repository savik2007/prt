defmodule PRT.Factory do
  use ExMachina.Ecto, repo: PRT.Repo

  alias PRT.Post
  alias PRT.User

  def user_factory do
    %User{
      name: "Xxx Yyy",
    }
  end

  def post_factory do
    %Post{
      kind: "article",
      text: "The post`s body",
      user: build(:user)
    }
  end
end