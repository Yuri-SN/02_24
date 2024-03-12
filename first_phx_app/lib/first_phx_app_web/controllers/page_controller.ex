defmodule FirstPhxAppWeb.PageController do
  use FirstPhxAppWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def hello(conn, params) do
    render(conn, :hello, user: get_user(params), users: params["users"])
  end

  # private

  defp get_user(%{"user" => user}), do: user
  defp get_user(_params), do: "User"
end
