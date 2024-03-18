defmodule Store.TaggableTest do
  use Store.DataCase

  alias Store.Taggable

  describe "add product" do
    test "with few new tags" do
      params = %{
        title: "Test Product",
        tags: [
          %{name: "First Tag"},
          %{name: "Second Tag"},
          %{name: "Third Tag"}
        ]
      }

      product = Taggable.create_product(params)

      first_tag =
        product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.first()

      assert product.title == params.title
      assert length(product.tags) == length(params.tags)
      assert first_tag == "First Tag"
    end

    test "with one new tag" do
      Taggable.create_tag(%{name: "Old Tag"})

      product_params = %{title: "Test Product", tags: [%{name: "Old Tag"}, %{name: "New Tag"}]}

      product =
        product_params
        |> Taggable.create_product()

      first_tag =
        product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.first()

      last_tag =
        product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.last()

      assert length(product.tags) == 2
      assert first_tag == "New Tag"
      assert last_tag == "Old Tag"
    end

    test "without tags" do
      product_params = %{title: "Test Product"}

      product =
        product_params
        |> Taggable.create_product()

      assert length(product.tags) == 0
    end
  end

  describe "get products by tag name" do
    test "without products" do
      tag_params = %{name: "First Tag"}

      Taggable.create_tag(tag_params)

      tag_with_products = Taggable.get_tag_by_name_with_products(tag_params)

      assert length(tag_with_products.products) == 0
    end

    test "with few products" do
      first_product_params = %{
        title: "First Product",
        tags: [%{name: "Mega Tag"}]
      }

      second_product_params = %{
        title: "Second Product",
        tags: [%{name: "Mega Tag"}]
      }

      Taggable.create_product(first_product_params)
      Taggable.create_product(second_product_params)

      tag_with_products = Taggable.get_tag_by_name_with_products(%{name: "Mega Tag"})

      assert length(tag_with_products.products) == 2
    end

    test "nonexistent tag name" do
      tag_params = %{name: "First Tag"}

      tag_with_products = Taggable.get_tag_by_name_with_products(tag_params)

      assert tag_with_products == nil
    end
  end

  describe "update product" do
    test "without tags" do
      product_params = %{title: "Test Product"}
      new_tag_params = [%{name: "New Tag"}]

      product =
        product_params
        |> Taggable.create_product()

      updated_product = Taggable.update_product_tags(product, new_tag_params)

      first_tag =
        updated_product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.first()

      assert length(updated_product.tags) == 1
      assert first_tag == "New Tag"
    end

    test "with one tag" do
      product_params = %{title: "Test Product", tags: [%{name: "Old Tag"}]}
      new_tag_params = [%{name: "New Tag"}]

      product =
        product_params
        |> Taggable.create_product()

      updated_product = Taggable.update_product_tags(product, new_tag_params)

      first_tag =
        updated_product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.first()

      last_tag =
        updated_product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.last()

      assert length(updated_product.tags) == 2
      assert first_tag == "New Tag"
      assert last_tag == "Old Tag"
    end
  end

  describe "tags" do
    test "delete tag with products" do
      product_params = %{
        title: "Test Product",
        tags: [%{name: "First Tag"}, %{name: "Second Tag"}]
      }

      new_product =
        product_params
        |> Taggable.create_product()

      {:ok, _tag} = Taggable.delete_tag_by_name("Second Tag")

      product = Taggable.get_product_by_id_with_tags(new_product.id)

      first_tag =
        product.tags
        |> Taggable.product_tags_names()
        |> Enum.sort()
        |> List.first()

      assert length(product.tags) == 1
      assert first_tag == "First Tag"
    end
  end
end
