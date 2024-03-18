defmodule Store.Taggable do
  @moduledoc """
  The Taggable context.
  """

  import Ecto.Query, warn: false

  alias Store.Repo
  alias Store.Taggable.{Product, Tag, Tagging}

  # Products

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products(limit \\ 50, offset \\ 0) do
    Repo.all(
      from p in Product,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset
    )
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  def get_product_with_tags(id), do: Repo.get(Product, id) |> Repo.preload(:tags)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    {:ok, product} =
      %Product{}
      |> Product.changeset(attrs)
      |> Repo.insert()

    update_product_tags(product, attrs[:tags])
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  # Tags

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags(limit \\ 50, offset \\ 0) do
    Repo.all(
      from t in Tag,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset
    )
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  def get_tag_by_name!(name), do: Repo.get_by!(Tag, name: name)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def delete_tag_by_name(name) do
    get_tag_by_name!(name)
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  # Taggings

  @doc """
  Returns the list of taggings.

  ## Examples

      iex> list_taggings()
      [%Tagging{}, ...]

  """
  def list_taggings(limit \\ 50, offset \\ 0) do
    Repo.all(
      from t in Tagging,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset
    )
  end

  @doc """
  Gets a single tagging.

  Raises `Ecto.NoResultsError` if the Tagging does not exist.

  ## Examples

      iex> get_tagging!(123)
      %Tagging{}

      iex> get_tagging!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tagging!(id), do: Repo.get!(Tagging, id)

  @doc """
  Creates a tagging.

  ## Examples

      iex> create_tagging(%{field: value})
      {:ok, %Tagging{}}

      iex> create_tagging(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tagging(attrs \\ %{}) do
    %Tagging{}
    |> Tagging.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tagging.

  ## Examples

      iex> update_tagging(tagging, %{field: new_value})
      {:ok, %Tagging{}}

      iex> update_tagging(tagging, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tagging(%Tagging{} = tagging, attrs) do
    tagging
    |> Tagging.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tagging.

  ## Examples

      iex> delete_tagging(tagging)
      {:ok, %Tagging{}}

      iex> delete_tagging(tagging)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tagging(%Tagging{} = tagging) do
    Repo.delete(tagging)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tagging changes.

  ## Examples

      iex> change_tagging(tagging)
      %Ecto.Changeset{data: %Tagging{}}

  """
  def change_tagging(%Tagging{} = tagging, attrs \\ %{}) do
    Tagging.changeset(tagging, attrs)
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

    get_product_with_tags(product.id)
  end

  def update_product_tags(product, _tags_params) do
    get_product_with_tags(product.id)
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
