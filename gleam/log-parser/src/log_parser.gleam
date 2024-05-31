import gleam/option.{type Option, None, Some}
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) =
    regex.from_string("(\\[DEBUG\\]|\\[INFO\\]|\\[WARNING\\]|\\[ERROR\\])")
  regex.check(re, line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regex.from_string("<[~*=-]*>")
  regex.split(content: line, with: re)
}

pub fn tag_with_user_name(line: String) -> String {
  case get_user_name(line) {
    None -> line
    Some(user_name) -> "[USER] " <> user_name <> " " <> line
  }
}

fn get_user_name(line: String) -> Option(String) {
  let assert Ok(re) = regex.from_string("User\\s+([^\\s]+)")

  case regex.scan(re, line) {
    [] -> None
    [match] ->
      case match.submatches {
        [] -> None
        [user_name] -> user_name
        _ -> panic
      }
    _ -> panic
  }
}
