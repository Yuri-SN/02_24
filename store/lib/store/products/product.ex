defmodule Store.Products.Product do
  use Store.Schema

  import Ecto.Changeset

  schema "products" do
    field :title, :string

    has_many :taggings, Store.Taggable.Tagging
    has_many :tags, through: [:taggings, :tag]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
