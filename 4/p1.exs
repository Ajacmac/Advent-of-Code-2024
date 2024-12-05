defmodule DayFour do
  @on_load :init
  def init do
    {:ok, content} = File.read("input.txt")

    grid =
      content
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    rows = length(grid)
    cols = length(hd(grid))

    directions = [
      # right
      {0, 1},
      # left
      {0, -1},
      # down
      {1, 0},
      # up
      {-1, 0},
      # down-right
      {1, 1},
      # down-left
      {1, -1},
      # up-right
      {-1, 1},
      # up-left
      {-1, -1}
    ]

    for row <- 0..(rows - 1),
        col <- 0..(cols - 1),
        dir <- directions,
        has_xmas?(grid, row, col, dir),
        reduce: 0 do
      acc -> acc + 1
    end
  end

  defp has_xmas?(grid, row, col, {dx, dy}) do
    try do
      word =
        for i <- 0..3 do
          row_idx = row + i * dx
          col_idx = col + i * dy

          if row_idx < 0 or col_idx < 0 do
            raise "Out of bounds"
          end

          grid |> Enum.at(row_idx) |> Enum.at(col_idx)
        end
        |> Enum.join()

      word == "XMAS"
    rescue
      _ -> false
    end
  end
end
