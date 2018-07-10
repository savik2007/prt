defmodule PRT.User do
  @moduledoc false

  use Ecto.Schema

  schema "user" do
     field :name, :string
  end
end
