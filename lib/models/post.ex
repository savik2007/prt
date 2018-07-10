defmodule PRT.Post do
  @moduledoc false

  use Ecto.Schema

  schema "post" do
    field :kind, :string
    field :text, :string
    belongs_to :user, PRT.User
  end
end
