import gleam/string

pub opaque type TreasureChest(treasure) {
  TreasureChest(treasure: treasure, password: String)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case string.length(password) {
    count if count < 8 -> Error("Password must be at least 8 characters long")
    _ -> Ok(TreasureChest(contents, password))
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case chest.password == password {
    True -> Ok(chest.treasure)
    False -> Error("Incorrect password")
  }
}
