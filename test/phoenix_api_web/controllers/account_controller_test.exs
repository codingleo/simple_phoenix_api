defmodule PhoenixApiWeb.AccountControllerTest do
  use PhoenixApiWeb.ConnCase, async: true

  alias PhoenixApi.{User, Account}

  describe "deposit/2" do
    setup %{conn: conn} do
      user_params = %{
        name: "Nocivo",
        password: "nocivo124,",
        nickname: "nocivo",
        email: "nocivo@ribero.tech",
        age: 23
      }

      {:ok, %User{account: %Account{id: account_id}}} = PhoenixApi.create_user(user_params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "All params are valid", %{conn: conn, account_id: account_id} do
      params = %{value: "50.00"}

      response =
        conn
        |> post(Routes.account_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
        "account" => %{
          "balance" => "50.00",
          "id" => _id
        },
        "message" => "Balance changed successfully!"
      } = response
    end

    test "When there's invalid params", %{conn: conn, account_id: account_id} do
      params = %{value: "banana"}

      response =
        conn
        |> post(Routes.account_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid deposit value"} == response
    end
  end
end
