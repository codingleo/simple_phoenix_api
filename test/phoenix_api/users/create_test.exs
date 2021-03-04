defmodule PhoenixApi.Users.CreateTest do
  use PhoenixApi.DataCase, async: true

  alias PhoenixApi.{User, Repo}
  alias PhoenixApi.Users.Create

  describe "call/1" do
    test "when all params are valid, returns a user" do
      params = %{
        name: "Nocivo",
        password: "nocivo124,",
        nickname: "nocivo",
        email: "nocivo@ribero.tech",
        age: 23
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Nocivo", age: 23, id: ^user_id} = user
    end

    test "when passed invalid params" do
      params = %{
        name: "Nocivo",
        password: "no",
        nickname: "nocivo",
        email: "nocivo@ribero.tech",
        age: 18
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{password: ["should be at least 6 character(s)"]}

      assert expected_response == errors_on(changeset)
    end
  end
end
