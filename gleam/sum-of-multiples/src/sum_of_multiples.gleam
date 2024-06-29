import gleam/int
import gleam/list
import gleam/set.{type Set}

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  factors
  |> list.map(bulld_multiple_set(_, limit - 1, set.new()))
  |> list.fold(set.new(), fn(set, subset) { set.union(set, subset) })
  |> set.to_list
  |> int.sum
}

fn bulld_multiple_set(
  factor: Int,
  max_multiple: Int,
  multiple_set: Set(Int),
) -> Set(Int) {
  case max_multiple < factor || max_multiple <= 0 {
    True -> multiple_set
    False -> {
      let multiple = max_multiple / factor * factor

      bulld_multiple_set(
        factor,
        multiple - factor,
        set.insert(multiple_set, multiple),
      )
    }
  }
}
