defmodule PhoenixTodo.Todos.ItemQuery do
  import Ecto.Query

  def user_todos_query(query, %PhoenixTodo.Accounts.User{id: user_id}) do
    from t in query, where: t.user_id == ^user_id
  end
end
