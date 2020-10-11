defmodule PhoenixTodo.Todos.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :description, :string
    field :is_done, :boolean, default: false
    field :priority, :string

    belongs_to :user, PhoenixTodo.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:description, :priority, :is_done])
    |> validate_required([:description, :priority, :is_done])
  end
end
