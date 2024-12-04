defmodule DayThree do
  @on_load :init
  def init do
    IO.puts("running")

    {:ok, content} = File.read("input.txt")

    content
    |> String.trim()
    |> String.split(~r/(do\(\)|don't\(\))/, include_captures: true)
    |> Enum.reject(&(&1 == ""))
    |> process_segments(true, [])
    |> List.flatten()
    |> Enum.sum()
    |> IO.inspect(label: "Final sum")
  end

  defp process_segments([], _enabled, results), do: results

  defp process_segments([segment | rest], enabled, results) do
    case segment do
      "do()" ->
        process_segments(rest, true, results)

      "don't()" ->
        process_segments(rest, false, results)

      text ->
        mults =
          if enabled do
            Regex.scan(~r/mul\((\d+),(\d+)\)/, text)
            |> Enum.map(fn [_full, n1, n2] ->
              String.to_integer(n1) * String.to_integer(n2)
            end)
          else
            []
          end

        process_segments(rest, enabled, [mults | results])
    end
  end
end
