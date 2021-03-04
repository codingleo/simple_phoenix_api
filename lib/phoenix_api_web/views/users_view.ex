defmodule PhoenixApiWeb.UsersView do
  alias PhoenixApi.{User, Account}

  def render("create.json", %{user: %User{account: %Account{} = account, id: id, name: name, nickname: nickname}}) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account.id,
          balance: account.balance
        }
      }
    }
  end
end
