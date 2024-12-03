defmodule DayTwo do
  @on_load :init
  def init do
    # take cli arguments
    # split into lines
    # accumulate sums
    System.argv()
    |> List.first()
    |> case do
      nil ->
        IO.puts("Please prove a file path")

      path ->
        case File.read(path) do
          {:error, reason} ->
            IO.puts(reason)

          {:ok, content} ->
            String.trim(content)
            |> String.split("\n")
            |> Enum.map(&process_line/1)
            |> Enum.sum()
            |> IO.puts()
        end
    end

    :ok
  end

  def process_line(line) do
    numbers =
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)

    valid =
      Enum.any?(0..(length(numbers) - 1), fn i ->
        test_numbers = List.delete_at(numbers, i)
        pairs = Enum.chunk_every(test_numbers, 2, 1, :discard)
        valid_sequence?(pairs)
      end)

    original_valid = valid_sequence?(Enum.chunk_every(numbers, 2, 1, :discard))

    if valid or original_valid, do: 1, else: 0
  end

  defp valid_sequence?(pairs) do
    Enum.all?(pairs, fn [x, y] ->
      diff = y - x

      diff != 0 and abs(diff) <= 3 and
        diff > 0 == Enum.all?(pairs, fn [a, b] -> b > a end)
    end)
  end
end
