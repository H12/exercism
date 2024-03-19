pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    _ if guess >= 44 -> "Too high"
    _ if guess <= 40 -> "Too low"
    _ -> "So close"
  }
}
