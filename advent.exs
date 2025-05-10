defmodule Advent do
  def day_01_part_1(list_one, list_two) do
    # Calculating the distance between lists
    list_one = Enum.sort(list_one)
    list_two = Enum.sort(list_two)

    Enum.zip(list_one, list_two)
    |> Enum.reduce(0, fn {left, right}, acc ->
      acc + abs(left - right)
    end)
  end

  def day_01_part_2(list_one, list_two) do
    # Calculating frequencies score
    counts_one = Enum.frequencies(list_one)
    counts_two = Enum.frequencies(list_two)

    Enum.reduce(counts_one, 0, fn {number, freq}, acc ->
      acc + number * freq * Map.get(counts_two, number, 0)
    end)
  end
end

_ = Code.require_file("input_lists.ex")
{list_one, list_two} = InputLists.lists()

IO.inspect("Day 01 part 1: #{Advent.day_01_part_1(list_one, list_two)}")
IO.inspect("Day 01 part 2: #{Advent.day_01_part_2(list_one, list_two)}")
