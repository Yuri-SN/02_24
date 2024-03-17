defmodule Store.Taggable.Tag do
  use Store.Schema

  import Ecto.Changeset

  schema "tags" do
    field :name, :string

    has_many :taggings, Store.Taggable.Tagging
    has_many :products, through: [:taggings, :product]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name, name: :tags_name_index)
  end
end
