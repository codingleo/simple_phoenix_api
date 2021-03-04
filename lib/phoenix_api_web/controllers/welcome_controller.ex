defmodule PhoenixApiWeb.WelcomeController do
  use PhoenixApiWeb, :controller

  alias PhoenixApi.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to Phoenix API. Here's your number: #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: reason})
  end
end
