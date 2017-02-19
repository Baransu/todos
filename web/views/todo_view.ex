defmodule Todos.TodoView do
  use Todos.Web, :view

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, Todos.TodoView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, Todos.TodoView, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      title: todo.title,
      description: todo.description}
  end
end
