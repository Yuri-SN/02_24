defmodule Store.TaggableTest do
  use Store.DataCase

  import Store.ProductsFixtures

  alias Store.Taggable
  alias Store.Products

  test "add tag to Product" do
    product = product_fixture()
    tag_name = "Test Tag"

    {:ok, tagging} = Taggable.tag_product(product, %{tag: %{name: tag_name}})

    assert tagging.product_id == product.id
    assert tagging.tag.name == tag_name
  end

  test "add many tags to Product" do
    product = product_fixture()
    new_tags = ["Test Tag #1", "Test Tag #2", "Test Tag #3"]

    new_tags
    |> Enum.each(fn tag_name -> Taggable.tag_product(product, %{tag: %{name: tag_name}}) end)

    product_with_tags = Products.get_product_with_tags!(product.id)

    product_tags =
      product_with_tags.tags
      |> Enum.map(fn tag -> tag.name end)

    assert length(product_with_tags.tags) == 3
    assert Enum.sort(new_tags) == Enum.sort(product_tags)
  end

  test "load Product tags" do
    tag_name = "Test Tag"
    product = product_with_tags_fixture([tag_name])
    [tag] = product.tags

    assert length(product.tags) == 1
    assert tag.name == tag_name
  end

  test "delete tag from Product" do
    tag_name = "Test Tag"
    product = product_with_tags_fixture([tag_name])
    [tag] = product.tags

    {:ok, tagging} = Taggable.delete_tag_from_product(product, tag)

    assert tagging.product_id == product.id
    assert tagging.tag_id == tag.id
  end
end
