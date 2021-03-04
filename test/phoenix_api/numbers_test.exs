defmodule PhoenixApi.NumbersTest do
  use ExUnit.Case, async: true

  alias PhoenixApi.Numbers

  describe "sum_from_file/1" do
    test "when there's a file with a given name, returns the sum of numbers" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there's no file with a given name, returns an error" do
      response = Numbers.sum_from_file("banana")

      expected_response = {:error, %{message: "Invalid file!"}}

      assert response == expected_response
    end

    test "when nothing is passed as params" do
      response = Numbers.sum_from_file()

      expected_response = {:error, %{message: "No file setted!"}}

      assert response == expected_response
    end
  end
end
