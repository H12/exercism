import gleam/string

pub fn hey(remark: String) -> String {
  case is_question(remark), is_shouting(remark), is_silent(remark) {
    True, False, _ -> "Sure."
    False, True, _ -> "Whoa, chill out!"
    True, True, _ -> "Calm down, I know what I'm doing!"
    _, _, True -> "Fine. Be that way!"
    _, _, _ -> "Whatever."
  }
}

fn is_question(remark: String) -> Bool {
  case remark |> string.trim |> string.last {
    Ok("?") -> True
    _ -> False
  }
}

fn is_shouting(remark: String) -> Bool {
  string.uppercase(remark) == remark && string.lowercase(remark) != remark
}

fn is_silent(remark: String) -> Bool {
  string.trim(remark) == ""
}
