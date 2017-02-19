defmodule Todos.Factory do
  use ExMachina.Ecto, repo: Todos.Repo

  def todo_factory do
    %Todos.Todo{
      title: "Some title",
      description: "Some description"
    }
  end
end
