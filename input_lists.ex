defmodule InputLists do
  def lists do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn row, {list_one, list_two} ->
      [left, right] = String.split(row, "   ")

      {
        [String.to_integer(left) | list_one],
        [String.to_integer(right) | list_two]
      }
    end)
  end
end
