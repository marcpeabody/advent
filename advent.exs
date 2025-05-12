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

  def day_03_part_1() do
    data = InputLists.corruption()

    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(data)
    |> Enum.reduce(0, fn [_, num1, num2], acc ->
      acc + String.to_integer(num1) * String.to_integer(num2)
    end)
  end

  def day_03_part_2() do
    data = InputLists.corruption()

    ~r/mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/
    |> Regex.scan(data)
    |> Enum.reduce({true, 0}, fn
      ["do()"], {_, sum} ->
        {true, sum}

      ["don't()"], {_, sum} ->
        {false, sum}

      [_mul, num1, num2], {true, sum} ->
        {true, sum + String.to_integer(num1) * String.to_integer(num2)}

      [_mul, _num1, _num2], acc ->
        acc
    end)
    |> elem(1)
  end

  def day_04_part_1() do
    crossword = InputLists.crossword()

    x_range = 0..length(crossword)
    y_range = 0..length(Enum.at(crossword, 0))
    xmas = ["X", "M", "A", "S"]
    directions = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]

    Enum.reduce(x_range, 0, fn x, row_acc ->
      Enum.reduce(y_range, row_acc, fn y, cell_acc ->
        Enum.reduce(directions, cell_acc, fn direction, acc ->
          acc + find_word(crossword, xmas, x, y, direction)
        end)
      end)
    end)
  end

  def find_word(_crossword, [], _x, _y, _direction), do: 0
  def find_word(_crossword, _word, x, y, _direction) when x < 0 or y < 0, do: 0

  def find_word(crossword, [next_letter | rest] = _word, x, y, direction) do
    with row when is_list(row) <- Enum.at(crossword, x),
         letter when is_binary(letter) <- Enum.at(row, y),
         true <- letter == next_letter do
      if rest == [] do
        1
      else
        [x_delta, y_delta] = direction
        find_word(crossword, rest, x + x_delta, y + y_delta, direction)
      end
    else
      _ ->
        0
    end
  end
end

_ = Code.require_file("input_lists.ex")
{list_one, list_two} = InputLists.lists()

IO.inspect("Day 01 part 1: #{Advent.day_01_part_1(list_one, list_two)}")
IO.inspect("Day 01 part 2: #{Advent.day_01_part_2(list_one, list_two)}")
IO.inspect("Day 02 part 1: #{Advent.day_02_part_1()}")
IO.inspect("Day 02 part 2: #{Advent.day_02_part_2()}")
IO.inspect("Day 03 part 1: #{Advent.day_03_part_1()}")
IO.inspect("Day 03 part 2: #{Advent.day_03_part_2()}")
IO.inspect("Day 04 part 1: #{Advent.day_04_part_1()}")
