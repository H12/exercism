import gleam/int
import gleam/iterator
import gleam/list
import gleam/set.{type Set}

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  factors
  |> list.map(multiples(of: _, not_exceeding: limit - 1))
  |> list.fold(set.new(), set.union)
  |> set.to_list
  |> int.sum
}

fn multiples(of factor: Int, not_exceeding max: Int) -> Set(Int) {
  case factor {
    0 -> set.new()
    _ ->
      iterator.iterate(from: factor, with: int.add(factor, _))
      |> iterator.take_while(satisfying: fn(multiple) { multiple <= max })
      |> iterator.fold(set.new(), set.insert)
  }
}
