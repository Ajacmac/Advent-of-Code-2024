defmodule DayThree do
  @on_load :init
  def init do
    IO.puts("running")

    {:ok, content} = File.read("input.txt")

    content
    |> String.trim()
    |> then(fn content ->
      matches = Regex.scan(~r/(?:mul\()(\d+)(?:,)(\d+)(?:\))/, content)
      IO.inspect(matches, label: "Matches found")
      matches
    end)
    |> Enum.map(fn [_full, n1, n2] ->
      String.to_integer(n1) * String.to_integer(n2)
    end)
    |> then(fn results ->
      IO.inspect(results, label: "Multipled results")
      results
    end)
    |> Enum.sum()
    |> IO.inspect(label: "Final sum")

    :ok
  end
end
