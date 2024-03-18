import Ecto.Changeset

alias Store.Repo
alias Store.Taggable
alias Store.Taggable.{Product, Tag, Tagging}

# attrs = %{
#   title: "Temp Product",
#   taggings: [
#     %{name: "Tag number one"},
#     %{name: "Tag number two"}
#   ]
# }

# %Product{}
# |> cast(attrs, [:title])
# |> validate_required([:title])
# |> cast_assoc(:taggings)
# |> Repo.insert()

# def tag_product(product, %{tag: tag_attrs} = attrs) do
#   tag = create_or_find_tag(tag_attrs)

#   product
#   |> Ecto.build_assoc(:taggings)
#   |> Tagging.changeset(attrs)
#   |> Ecto.Changeset.put_assoc(:tag, tag)
#   |> Repo.insert()
# end
