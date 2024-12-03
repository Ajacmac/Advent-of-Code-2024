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

    pairs =
      numbers
      |> Enum.chunk_every(2, 1, :discard)

    case pairs do
      [] ->
        0

      [pair | rest] ->
        [a, b] = pair
        first_diff = b - a

        valid =
          pairs
          |> Enum.all?(fn [x, y] ->
            diff = y - x

            diff * first_diff > 0 and abs(diff) in 1..3
          end)

        if valid, do: 1, else: 0
    end
  end
end
