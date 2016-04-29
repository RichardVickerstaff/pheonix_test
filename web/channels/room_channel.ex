defmodule PhoenixWebpack.RoomChannel do
  use Phoenix.Channel

  alias PhoenixWebpack.Message
  alias PhoenixWebpack.Repo

  def join("rooms:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

   def handle_in("new_msg", params, socket) do
    changeset = Message.changeset(%Message{}, params)
    case Repo.insert(changeset) do
      {:ok, message} ->
         broadcast! socket, "new_msg", %{body: message.body, inserted_at: message.inserted_at}
         {:noreply, socket}
      {:error, changeset} ->
        IO.puts changeset
    end
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end
end

