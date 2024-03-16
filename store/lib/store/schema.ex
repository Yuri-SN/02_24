defmodule Store.Schema do
  @moduledoc """
  For generate UUIDv7 as DB keys
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, Uniq.UUID, version: 7, autogenerate: true, type: :uuid}
      @foreign_key_type Uniq.UUID
    end
  end
end
