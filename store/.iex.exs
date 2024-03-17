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
