defmodule PhoenixTodoWeb.TodoController do
  use PhoenixTodoWeb, :controller

  alias PhoenixTodo.Todos

  plug :authenticate_user

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _, current_user) do
    items = Todos.list_user_items(current_user)
    render(conn, "index.html", items: items)
  end

  def new(conn, _params, _current_user) do
    changeset = Todos.change_item(%Todos.Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}, current_user) do
    case Todos.create_item(current_user, item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Todo item created successfully,")
        |> redirect(to: Routes.todo_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    item = Todos.get_user_todo_item!(current_user, id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}, current_user) do
    item = Todos.get_user_todo_item!(current_user, id)
    changeset = Todos.change_item(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}, current_user) do
    item = Todos.get_user_todo_item!(current_user, id)

    case Todos.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully")
        |> redirect(to: Routes.todo_path(conn, :show, item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    item = Todos.get_user_todo_item!(current_user, id)
    {:ok, _item} = Todos.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
