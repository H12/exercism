pub fn convert(number: Int) -> String {
  numeral_loop(number, "")
}

fn numeral_loop(number: Int, numeral: String) {
  case number {
    _ if number >= 1000 -> numeral_loop(number - 1000, numeral <> "M")
    _ if number >= 900 -> numeral_loop(number - 900, numeral <> "CM")
    _ if number >= 500 -> numeral_loop(number - 500, numeral <> "D")
    _ if number >= 400 -> numeral_loop(number - 400, numeral <> "CD")
    _ if number >= 100 -> numeral_loop(number - 100, numeral <> "C")
    _ if number >= 90 -> numeral_loop(number - 90, numeral <> "XC")
    _ if number >= 50 -> numeral_loop(number - 50, numeral <> "L")
    _ if number >= 40 -> numeral_loop(number - 40, numeral <> "XL")
    _ if number >= 10 -> numeral_loop(number - 10, numeral <> "X")
    _ if number >= 9 -> numeral_loop(number - 9, numeral <> "IX")
    _ if number >= 5 -> numeral_loop(number - 5, numeral <> "V")
    _ if number >= 4 -> numeral_loop(number - 4, numeral <> "IV")
    _ if number >= 1 -> numeral_loop(number - 1, numeral <> "I")
    _ -> numeral
  }
}
