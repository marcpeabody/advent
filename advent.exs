defmodule Advent do
  def day_01(list_one, list_two) do
    list_one = Enum.sort(list_one)
    list_two = Enum.sort(list_two)

    Enum.zip(list_one, list_two)
    |> Enum.reduce(0, fn {left, right}, acc ->
      acc + abs(left - right)
    end)
  end

  def day_02(_list_one, _list_two) do
  end
end

# [_this_file | _days] = System.argv()

_ = Code.require_file("input_lists.ex")
{list_one, list_two} = InputLists.lists()

# file_name = "day_#{String.pad_leading(i, 2, "0")}.exs"
IO.inspect("Day 01: #{Advent.day_01(list_one, list_two)}")
IO.inspect("Day 02: #{Advent.day_02(list_one, list_two)}")
