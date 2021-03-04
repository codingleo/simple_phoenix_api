defmodule PhoenixApiWeb.FallbackController do
  use PhoenixApiWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PhoenixApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
