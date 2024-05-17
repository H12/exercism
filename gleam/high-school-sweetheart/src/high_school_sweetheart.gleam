import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  name
  |> string.first
  |> result.unwrap("")
}

pub fn initial(name: String) {
  todo
}

pub fn initials(full_name: String) {
  todo
}

pub fn pair(full_name1: String, full_name2: String) {
  //      ******       ******
  //    **      **   **      **
  //  **         ** **         **
  // **            *            **
  // **                         **
  // **     X. X.  +  X. X.     **
  //  **                       **
  //    **                   **
  //      **               **
  //        **           **
  //          **       **
  //            **   **
  //              ***
  //               *
  todo
}
