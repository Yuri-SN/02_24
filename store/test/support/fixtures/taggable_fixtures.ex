defmodule Store.TaggableFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Taggable` context.
  """

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Store.Taggable.create_tag()

    tag
  end

  @doc """
  Generate a tagging.
  """
  def tagging_fixture(attrs \\ %{}) do
    {:ok, tagging} =
      attrs
      |> Enum.into(%{

      })
      |> Store.Taggable.create_tagging()

    tagging
  end
end
