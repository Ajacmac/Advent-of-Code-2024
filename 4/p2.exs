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

    count =
      for row <- 0..(rows - 2),
          col <- 1..(cols - 2),
          is_xmas_pattern?(grid, row, col),
          reduce: 0 do
        acc -> acc + 1
      end
  end

  defp is_xmas_pattern?(grid, center_row, center_col) do
    upper_left = [
      get_char(grid, center_row - 1, center_col - 1),
      get_char(grid, center_row, center_col),
      get_char(grid, center_row + 1, center_col + 1)
    ]

    upper_right = [
      get_char(grid, center_row - 1, center_col + 1),
      get_char(grid, center_row, center_col),
      get_char(grid, center_row + 1, center_col - 1)
    ]

    is_mas_pattern?(upper_left) and is_mas_pattern?(upper_right)
  end

  defp is_mas_pattern?(chars) do
    chars == ["M", "A", "S"] or chars == ["S", "A", "M"]
  end

  defp get_char(grid, row, col) do
    grid |> Enum.at(row) |> Enum.at(col)
  end
end
