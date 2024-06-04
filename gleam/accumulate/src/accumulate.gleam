pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  optimized_accumulate(list, fun, [])
}

fn optimized_accumulate(
  list: List(a),
  fun: fn(a) -> b,
  accumulator: List(b),
) -> List(b) {
  case list {
    [] -> reverse(accumulator, [])
    [head, ..tail] ->
      optimized_accumulate(tail, fun, [fun(head), ..accumulator])
  }
}

fn reverse(list: List(a), accumulator: List(a)) -> List(a) {
  case list {
    [] -> accumulator
    [head, ..tail] -> reverse(tail, [head, ..accumulator])
  }
}
