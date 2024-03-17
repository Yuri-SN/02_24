defmodule Store.Taggable.Tagging do
  use Store.Schema

  import Ecto.Changeset

  schema "taggings" do
    belongs_to :tag, Store.Taggable.Tag
    belongs_to :product, Store.Taggable.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tagging, attrs) do
    tagging
    |> cast(attrs, [])
    |> validate_required([:tag_id, :product_id])
    |> unique_constraint(:name, name: :taggings_tag_id_product_id_index)
    |> cast_assoc(:tag)
  end
end
