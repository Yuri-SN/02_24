defmodule Store.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Store.Products` context.
  """

  alias Store.Taggable

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Store.Products.create_product()

    product
  end

  def product_with_tags_fixture(attrs \\ ["Some tag"]) do
    product = product_fixture()

    attrs
    |> Enum.each(fn tag_name -> Taggable.tag_product(product, %{tag: %{name: tag_name}}) end)

    Store.Products.get_product_with_tags!(product.id)
  end
end
