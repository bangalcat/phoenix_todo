defmodule PhoenixTodoWeb.SessionController do
  use PhoenixTodoWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do
    case PhoenixTodo.Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> PhoenixTodoWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> PhoenixTodoWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
