content = File.read!("./input.txt")

{list_one, list_two} =
  content
  |> String.split("\n")
  |> Enum.reduce({[], []}, fn row, {list_one, list_two} ->
    [left, right] = String.split(row, "   ")

    {
      [String.to_integer(left) | list_one],
      [String.to_integer(right) | list_two]
    }
  end)

list_one = Enum.sort(list_one)
list_two = Enum.sort(list_two)

result =
  Enum.zip(list_one, list_two)
  |> Enum.reduce(0, fn {left, right}, acc ->
    acc + abs(left - right)
  end)

IO.puts(result)
