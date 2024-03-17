defmodule Store.TaggableTest do
  use Store.DataCase

  alias Store.Taggable

  describe "products" do
    alias Store.Taggable.Product

    import Store.TaggableFixtures

    @invalid_attrs %{title: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Taggable.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Taggable.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Product{} = product} = Taggable.create_product(valid_attrs)
      assert product.title == "some title"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taggable.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Product{} = product} = Taggable.update_product(product, update_attrs)
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Taggable.update_product(product, @invalid_attrs)
      assert product == Taggable.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Taggable.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Taggable.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Taggable.change_product(product)
    end
  end

  describe "tags" do
    alias Store.Taggable.Tag

    import Store.TaggableFixtures

    @invalid_attrs %{name: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Taggable.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Taggable.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Tag{} = tag} = Taggable.create_tag(valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taggable.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Tag{} = tag} = Taggable.update_tag(tag, update_attrs)
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Taggable.update_tag(tag, @invalid_attrs)
      assert tag == Taggable.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Taggable.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Taggable.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Taggable.change_tag(tag)
    end
  end

  describe "taggings" do
    alias Store.Taggable.Tagging

    import Store.TaggableFixtures

    @invalid_attrs %{}

    test "list_taggings/0 returns all taggings" do
      tagging = tagging_fixture()
      assert Taggable.list_taggings() == [tagging]
    end

    test "get_tagging!/1 returns the tagging with given id" do
      tagging = tagging_fixture()
      assert Taggable.get_tagging!(tagging.id) == tagging
    end

    test "create_tagging/1 with valid data creates a tagging" do
      valid_attrs = %{}

      assert {:ok, %Tagging{} = tagging} = Taggable.create_tagging(valid_attrs)
    end

    test "create_tagging/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taggable.create_tagging(@invalid_attrs)
    end

    test "update_tagging/2 with valid data updates the tagging" do
      tagging = tagging_fixture()
      update_attrs = %{}

      assert {:ok, %Tagging{} = tagging} = Taggable.update_tagging(tagging, update_attrs)
    end

    test "update_tagging/2 with invalid data returns error changeset" do
      tagging = tagging_fixture()
      assert {:error, %Ecto.Changeset{}} = Taggable.update_tagging(tagging, @invalid_attrs)
      assert tagging == Taggable.get_tagging!(tagging.id)
    end

    test "delete_tagging/1 deletes the tagging" do
      tagging = tagging_fixture()
      assert {:ok, %Tagging{}} = Taggable.delete_tagging(tagging)
      assert_raise Ecto.NoResultsError, fn -> Taggable.get_tagging!(tagging.id) end
    end

    test "change_tagging/1 returns a tagging changeset" do
      tagging = tagging_fixture()
      assert %Ecto.Changeset{} = Taggable.change_tagging(tagging)
    end
  end
end
