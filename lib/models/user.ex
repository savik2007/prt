defmodule PRT.User do
  @moduledoc false

  use Ecto.Schema

  schema "user" do
     field :name, :string
     has_many :post, PRT.Post
  end
end
