import gleam/string

pub fn message(log_line: String) -> String {
  let full_msg = case log_line {
    "[INFO]: " <> msg -> msg
    "[WARNING]: " <> msg -> msg
    "[ERROR]: " <> msg -> msg
    _ -> "invalid"
  }

  string.trim(full_msg)
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]" <> _ -> "info"
    "[WARNING]" <> _ -> "warning"
    "[ERROR]" <> _ -> "error"
    _ -> "invalid"
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
