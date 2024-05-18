import gleam/list
import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  name
  |> string.trim
  |> string.first
  |> result.unwrap("")
}

pub fn initial(name: String) {
  name
  |> first_letter
  |> string.uppercase
  |> string.append(".")
}

pub fn initials(full_name: String) {
  full_name
  |> string.split(" ")
  |> list.map(initial)
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     N. 1.  +  N. 2.     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
  |> string.replace("N. 1.", initials(full_name1))
  |> string.replace("N. 2.", initials(full_name2))
}
