import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Forth {
  Forth(stack: List(Int), words: Dict(String, Operator))
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

type Operator =
  fn(Forth) -> Result(Forth, ForthError)

type Entry {
  Value(Int)
  Word(Operator)
}

pub fn new() -> Forth {
  Forth([], dict.new())
  |> define_word("+", add)
  |> define_word("-", subtract)
  |> define_word("*", multiply)
  |> define_word("/", divide)
  |> define_word("DUP", duplicate)
  |> define_word("DROP", drop)
  |> define_word("SWAP", swap)
  |> define_word("OVER", over)
}

pub fn format_stack(f: Forth) -> String {
  case f {
    Forth([], _) -> ""
    Forth(stack, _) ->
      stack
      |> list.reverse
      |> list.map(int.to_string)
      |> string.join(" ")
  }
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  case f, prog {
    Forth(stack, words), "" -> Ok(Forth(stack, words))
    Forth(stack, words), _ -> {
      let #(entry_str, prog_rem) =
        prog
        |> string.split_once(" ")
        |> result.unwrap(#(prog, ""))

      entry_str
      |> string.uppercase
      |> parse_entry(f, _)
      |> result.try(fn(entry) {
        case entry {
          Value(num) -> eval(Forth([num, ..stack], words), prog_rem)
          Word(op) -> result.try(op(f), fn(next) { eval(next, prog_rem) })
        }
      })
    }
  }
}

fn define_word(f: Forth, word: String, op: Operator) -> Forth {
  Forth(
    stack: f.stack,
    words: dict.insert(insert: op, into: f.words, for: word),
  )
}

fn get_word(f: Forth, entry: String) -> Result(Entry, ForthError) {
  case dict.get(f.words, entry) {
    Ok(op) -> Ok(Word(op))
    Error(_) -> Error(UnknownWord)
  }
}

fn parse_entry(f: Forth, entry: String) -> Result(Entry, ForthError) {
  case int.parse(entry) {
    Ok(num) -> Ok(Value(num))
    _ -> get_word(f, entry)
  }
}

fn add(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest], words) -> Ok(Forth([b + a, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}

fn subtract(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest], words) -> Ok(Forth([b - a, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}

fn multiply(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest], words) -> Ok(Forth([b * a, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}

fn divide(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([0, ..], _words) -> Error(DivisionByZero)
    Forth([a, b, ..rest], words) -> Ok(Forth([b / a, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}

fn duplicate(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, ..rest], words) -> Ok(Forth([a, a, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}

fn drop(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([_a, ..rest], words) -> Ok(Forth(rest, words))
    _ -> Error(StackUnderflow)
  }
}

fn swap(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest], words) -> Ok(Forth([b, a, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}

fn over(f: Forth) -> Result(Forth, ForthError) {
  case f {
    Forth([a, b, ..rest], words) -> Ok(Forth([b, a, b, ..rest], words))
    _ -> Error(StackUnderflow)
  }
}
