defmodule PhoenixWebpack.PageController do
  use PhoenixWebpack.Web, :controller

  alias PhoenixWebpack.Message

  def index(conn, _params) do
    messages = Repo.all(Message)
    render(conn, "index.html", messages: messages)
  end
end
