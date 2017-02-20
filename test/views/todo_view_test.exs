defmodule Todos.TodoViewTest do
  use Todos.ModelCase
  import Todos.Factory
  alias Todos.TodoView

  test "index.json" do
    todo = insert(:todo)

    rendered_todos = TodoView.render("index.json", %{todos: [todo]})

    assert rendered_todos == %{
      data: [TodoView.render("todo.json", %{todo: todo})]
    }
  end

  test "show.json" do
    todo = insert(:todo)

    rendered_todo = TodoView.render("show.json", %{todo: todo})

    assert rendered_todo == %{
      data: TodoView.render("todo.json", %{todo: todo})
    }
  end

  test "todo.json" do
    todo = insert(:todo)

    rendered_todo = TodoView.render("todo.json", %{todo: todo})

    assert rendered_todo == %{
      id: todo.id,
      title: todo.title,
      description: todo.description,
      completed: todo.completed
    }
  end
end
