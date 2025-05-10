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

  def day_02_part_1() do
    InputLists.reports()
    |> Enum.reduce(0, fn report, acc ->
      acc + if safe?(report), do: 1, else: 0
    end)
  end

  def day_02_part_2() do
    InputLists.reports()
    |> Enum.reduce(0, fn report, acc ->
      safe? =
        safe?(report) or
          Enum.any?(0..length(report), fn i ->
            safe?(List.delete_at(report, i))
          end)

      if safe?, do: acc + 1, else: acc
    end)
  end

  def safe?([one, one | _tail]), do: false

  def safe?(list = [one, two | _tail]) do
    if one > two do
      safe?(list, :desc)
    else
      safe?(list, :asc)
    end
  end

  def safe?([one, two | tail], :asc) do
    cond do
      two - one > 3 -> false
      one >= two -> false
      true -> safe?([two | tail], :asc)
    end
  end

  def safe?([one, two | tail], :desc) do
    cond do
      one - two > 3 -> false
      two >= one -> false
      true -> safe?([two | tail], :desc)
    end
  end

  def safe?([_], _direction), do: true
end

_ = Code.require_file("input_lists.ex")
{list_one, list_two} = InputLists.lists()

IO.inspect("Day 01 part 1: #{Advent.day_01_part_1(list_one, list_two)}")
IO.inspect("Day 01 part 2: #{Advent.day_01_part_2(list_one, list_two)}")
IO.inspect("Day 02 part 1: #{Advent.day_02_part_1()}")
IO.inspect("Day 02 part 2: #{Advent.day_02_part_2()}")
