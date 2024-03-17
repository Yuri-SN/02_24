# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Store.Repo.insert!(%Store.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Store.Repo
alias Store.Taggable.{Product, Tag}

if Mix.env() != :dev do
  IO.puts("seed db only for 'dev' env")
  exit(:shutdown)
end

defmodule Tags do
  def add(attrs) do
    IO.puts(attrs.name)

    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert!()
  end
end

defmodule Products do
  def add(attrs) do
    IO.puts(attrs.title)

    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert!()
  end
end

# Create tags
tags_attrs = [
  %{name: "One"},
  %{name: "Two"},
  %{name: "Three"}
]

tags_attrs
|> Enum.each(fn t -> Tags.add(t) end)

# Create products
products_attrs = [
  %{title: "First Product"},
  %{title: "Second Product"},
  %{title: "Third Product"}
]

products_attrs
|> Enum.each(fn p -> Products.add(p) end)
