pub type TreasureChest(treasure) {
  TreasureChest(String, treasure)
}

pub type UnlockResult(treasure) {
  Unlocked(treasure)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    TreasureChest(actual_password, treasure) if actual_password == password ->
      Unlocked(treasure)
    _ -> WrongPassword
  }
}
