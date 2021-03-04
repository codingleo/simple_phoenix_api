defmodule PhoenixApiWeb.AccountController do
  use PhoenixApiWeb, :controller

  alias PhoenixApi.Account
  alias PhoenixApi.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback PhoenixApiWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- PhoenixApi.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- PhoenixApi.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    task = Task.async(fn ->
      PhoenixApi.transaction(params)
    end)

    with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
