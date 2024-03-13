defmodule FirstPhxAppWeb.PageControllerTest do
  use FirstPhxAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end

  test "GET /hello without params", %{conn: conn} do
    conn = get(conn, ~p"/hello")
    assert html_response(conn, 200) =~ "Hello, User!"
  end

  test "GET /hello with user in params", %{conn: conn} do
    conn = get(conn, ~p"/hello", user: "Yuri")
    assert html_response(conn, 200) =~ "Hello, Yuri!"
  end

  test "GET /hello with list of users", %{conn: conn} do
    users = ["Yoda", "Obi-Wan Kenobi", "Anakin Skywalker"]

    conn = get(conn, ~p"/hello", users: users)

    resp = html_response(conn, 200)

    assert resp =~ "Hello, Yoda!"
    assert resp =~ "Hello, Obi-Wan Kenobi!"
    assert resp =~ "Hello, Anakin Skywalker!"
  end
end
