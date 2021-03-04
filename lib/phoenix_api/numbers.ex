defmodule PhoenixApi.Numbers do
 def sum_from_file(filename) do
  "#{filename}.csv"
  |> File.read()
  |> handle_file()
 end

 def sum_from_file(), do: {:error, %{message: "No file setted!"}}

 defp handle_file({:ok, file}) do
  result =
    file
    |> String.replace(" ", "")
    |> String.split(",")
    |> Stream.map(fn number -> String.to_integer(number) end)
    |> Enum.sum()

  {:ok, %{result: result}}
 end

 defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file!"}}
end
