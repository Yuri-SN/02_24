defmodule Store.Repo.Migrations.CreateTaggings do
  use Ecto.Migration

  def change do
    create table(:taggings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :tag_id, references(:tags, on_delete: :delete_all, type: :binary_id), null: false

      add :product_id, references(:products, on_delete: :delete_all, type: :binary_id),
        null: false

      timestamps(type: :utc_datetime)
    end

    create index(:taggings, [:tag_id])
    create index(:taggings, [:product_id])
    create unique_index(:taggings, [:tag_id, :product_id])
  end
end
