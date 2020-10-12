defmodule PhoenixTodo.Factory do
  alias PhoenixTodo.{Accounts, Todos}

  @valid_user_args %{
    name: "user-#{:rand.uniform(1000)}",
    username: "username-#{:rand.uniform(1000)}",
    password: "testpass"
  }
  @valid_item_args %{description: "some description", is_done: true, priority: "some priority"}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_user_args)
      |> Accounts.create_user()

    user
  end

  def item_fixture(attrs \\ %{}) do
    user = user_fixture()

    attrs = Enum.into(attrs, @valid_item_args)
    {:ok, item} = Todos.create_item(user, attrs)

    item
  end
end
