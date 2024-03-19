defmodule Store.Taggable do
  @moduledoc """
  The Taggable context.
  """

  import Ecto.Query, warn: false

  alias Store.Repo
  alias Store.Taggable.{Product, Tag, Tagging}

  # Products

  def list_products(limit \\ 50, offset \\ 0) do
    Repo.all(
      from p in Product,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset
    )
  end

  def get_product!(id), do: Repo.get!(Product, id)

  def get_product_by_id_with_tags(id), do: Repo.get(Product, id) |> Repo.preload(:tags)

  def create_product(attrs \\ %{}) do
    {:ok, product} =
      %Product{}
      |> Product.changeset(attrs)
      |> Repo.insert()

    update_product_tags(product, attrs[:tags])
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  # Tags

  def list_tags(limit \\ 50, offset \\ 0) do
    Repo.all(
      from t in Tag,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset
    )
  end

  def get_tag_by_name(name), do: Repo.get_by(Tag, name: name)

  def get_tag_by_name_with_products(%{name: name}, limit \\ 50, offset \\ 0) do
    products_query =
      from p in Product,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset

    Repo.get_by(Tag, name: name)
    |> Repo.preload(products: products_query)

    # preload: [products: products_query]
    # )
  end

  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def delete_tag_by_name(name) do
    get_tag_by_name(name)
    |> Repo.delete()
  end

  def delete_tags(tags) when is_list(tags) do
    names =
      tags
      |> Enum.map(fn t -> t.name end)

    Tag
    |> where([t], t.name in ^names)
    |> Repo.delete_all()
  end

  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  # Taggings

  def create_tagging(attrs \\ %{}) do
    %Tagging{}
    |> Tagging.changeset(attrs)
    |> Repo.insert()
  end

  def update_product_tags(product, tags_params) when is_list(tags_params) do
    tags_params
    |> Enum.map(fn tag_params ->
      tag = create_or_find_tag(tag_params)

      create_tagging(%{
        product_id: product.id,
        tag_id: tag.id
      })
    end)

    get_product_by_id_with_tags(product.id)
  end

  def update_product_tags(product, _tags_params) do
    get_product_by_id_with_tags(product.id)
  end

  def create_or_find_tag(%{name: name} = attrs) when is_binary(name) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, tag} -> tag
      _ -> Repo.get_by(Tag, name: name)
    end
  end

  def create_or_find_tag(_), do: nil

  def product_tags_names(tags) when is_list(tags) do
    tags
    |> Enum.map(fn t -> t.name end)
  end

  def product_tags_names(_tags) do
    []
  end
end
