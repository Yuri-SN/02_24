defmodule Store.Taggable do
  @moduledoc """
  The Taggable context.
  """

  import Ecto.Query, warn: false

  alias Store.Repo
  alias Store.Taggable.{Tag, Tagging}

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags(limit \\ 500, offset \\ 0) do
    Repo.all(
      from t in Tag,
        order_by: [desc: :inserted_at],
        limit: ^limit,
        offset: ^offset
    )
  end

  def tag_product(product, %{tag: tag_attrs} = attrs) do
    tag = create_or_find_tag(tag_attrs)

    product
    |> Ecto.build_assoc(:taggings)
    |> Tagging.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:tag, tag)
    |> Repo.insert()
  end

  defp create_or_find_tag(%{name: name} = attrs) when is_binary(name) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, tag} -> tag
      _ -> Repo.get_by(Tag, name: name)
    end
  end

  defp create_or_find_tag(_), do: nil

  def delete_tag_from_product(product, tag) do
    Tagging
    |> Repo.get_by(product_id: product.id, tag_id: tag.id)
    |> case do
      %Tagging{} = tagging -> Repo.delete(tagging)
      nil -> {:ok, %Tagging{}}
    end
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

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  alias Store.Taggable.Tagging

  @doc """
  Returns the list of taggings.

  ## Examples

      iex> list_taggings()
      [%Tagging{}, ...]

  """
  def list_taggings do
    Repo.all(Tagging)
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
end
