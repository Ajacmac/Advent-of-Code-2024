File.read("input.txt")
|> case do
  {:ok, content} ->
    content
    # remove trailing whitespace
    |> String.trim()
    # split lines into separate strings
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.reduce({[], []}, fn {n1, n2}, {left, right} ->
      # build the two columns in reverse
      {[n1 | left], [n2 | right]}
    end)
    |> then(fn {left, right} ->
      Enum.zip(Enum.sort(left), Enum.sort(right))
    end)
    |> Enum.reduce(0, fn {l, r}, sum ->
      sum + abs(l - r)
    end)
    |> IO.puts()

  {:error, reason} ->
    {:error, reason}
end
