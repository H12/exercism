import gleam/list
import gleam/pair

pub fn rows(n: Int) -> List(List(Int)) {
  n |> build_rows([]) |> list.reverse
}

fn build_rows(n: Int, rows: List(List(Int))) -> List(List(Int)) {
  case n, rows {
    0, _ -> rows
    _, [] -> build_rows(n - 1, [[1]])
    _, [last, ..] -> build_rows(n - 1, [next_row(last), ..rows])
  }
}

fn next_row(row: List(Int)) -> List(Int) {
  row
  |> list.map_fold(from: 0, with: fn(acc, n) { #(n, n + acc) })
  |> pair.second
  |> list.append([1])
}
