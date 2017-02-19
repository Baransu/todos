defmodule Todos.PageControllerTest do
  use Todos.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello Todos!"
  end
end
