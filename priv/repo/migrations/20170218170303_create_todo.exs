defmodule Todos.Repo.Migrations.CreateTodo do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :description, :text
      add :completed, :boolean, default: false

      timestamps()
    end

  end
end
