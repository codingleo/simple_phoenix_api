defmodule PhoenixApiWeb.UsersController do
  use PhoenixApiWeb, :controller

  alias PhoenixApi.User

  action_fallback PhoenixApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- PhoenixApi.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
