defmodule Friends.Repo.Migrations.AddPostsTable do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :kind, :string
      add :text, :string
      add :user_id, references(:user, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
