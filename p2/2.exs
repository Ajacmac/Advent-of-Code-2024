File.read("input.txt")
|> case do
  {:error, reason} ->
    {:error, reason}

  {:ok, content} ->
    content
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.reduce({[], []}, fn {n1, n2}, {l, r} ->
      {[n1 | l], [n2 | r]}
    end)
    |> then(fn {l, r} ->
      r_freqs = Enum.frequencies(r)

      l
      |> Enum.map(fn num ->
        num * Map.get(r_freqs, num, 0)
      end)
      |> Enum.sum()
    end)
    |> IO.puts()
end
