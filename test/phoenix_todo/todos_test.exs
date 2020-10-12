defmodule PhoenixTodo.TodosTest do
  use PhoenixTodo.DataCase

  import PhoenixTodo.Factory

  alias PhoenixTodo.Todos

  describe "items" do
    alias PhoenixTodo.Todos.Item

    @valid_attrs %{description: "some description", is_done: true, priority: "some priority"}
    @update_attrs %{
      description: "some updated description",
      is_done: false,
      priority: "some updated priority"
    }
    @invalid_attrs %{description: nil, is_done: nil, priority: nil}

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Todos.get_item!(item.id).description == item.description
    end

    test "create_item/1 with valid data creates a item" do
      user = user_fixture()
      assert {:ok, %Item{} = item} = Todos.create_item(user, @valid_attrs)
      assert item.description == "some description"
      assert item.is_done == true
      assert item.priority == "some priority"
    end

    test "create_item/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.create_item(user, @invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Todos.update_item(item, @update_attrs)
      assert item.description == "some updated description"
      assert item.is_done == false
      assert item.priority == "some updated priority"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Todos.update_item(item, @invalid_attrs)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Todos.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Todos.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Todos.change_item(item)
    end
  end
end
