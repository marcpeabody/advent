defmodule InputLists do
  def lists do
    File.read!("day01_input.txt")
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn row, {list_one, list_two} ->
      [left, right] = String.split(row, "   ")

      {
        [String.to_integer(left) | list_one],
        [String.to_integer(right) | list_two]
      }
    end)
  end

  def reports do
    File.read!("day02_input.txt")
    |> String.split("\n")
    |> Enum.map(fn report ->
      report
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
