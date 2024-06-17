import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Forth {
  Forth(stack: List(Int))
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

type Operator = fn(Forth) -> Result(Forth, ForthError)

type Entry {
  Value(Int)
  Word(Operator)
}


pub fn new() -> Forth {
  Forth([])
}

pub fn format_stack(f: Forth) -> String {
  case f {
    Forth([]) -> ""
    Forth(stack) ->
      stack
      |> list.reverse
      |> list.map(int.to_string)
      |> string.join(" ")
  }
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  let #(entry, rest) = result.unwrap(string.split_once(prog, " "), #(prog, ""))

  case f, prog {
    Forth(stack), "" -> Ok(Forth(stack))
    Forth(stack), _ -> {
      use entry <- result.try(parse_entry(entry))
      case entry {
        Value(num) -> eval(Forth([num, ..stack]), rest)
        Word(op) -> result.try(op(f), fn(next) { eval(next, rest) })
      }
    }
  }
}

fn parse_entry(entry: String) -> Result(Entry, ForthError) {
  case int.parse(entry) {
    Ok(num) -> Ok(Value(num))
    _ ->
      case string.uppercase(entry) {
        "+" -> Ok(Word(add))
        "-" -> Ok(Word(subtract))
        "*" -> Ok(Word(multiply))
        "/" -> Ok(Word(divide))
        "DUP" -> Ok(Word(duplicate))
        "DROP" -> Ok(Word(drop))
        "SWAP" -> Ok(Word(swap))
        "OVER" -> Ok(Word(over))
        _ -> Error(InvalidWord)
      }
  }
}

fn add(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest]) -> Ok(Forth([b + a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

fn subtract(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest]) -> Ok(Forth([b - a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

fn multiply(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest]) -> Ok(Forth([b * a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

fn divide(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([0, .._]) -> Error(DivisionByZero)
    Forth([a, b, ..rest]) -> Ok(Forth([b / a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

fn duplicate(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, ..rest]) -> Ok(Forth([a, a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

fn drop(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, ..rest]) -> Ok(Forth(rest))
    _ -> Error(StackUnderflow)
  }
}

fn swap(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest]) -> Ok(Forth([b, a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

fn over(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest]) -> Ok(Forth([b, a, b, ..rest]))
    _ -> Error(StackUnderflow)
  }
}
