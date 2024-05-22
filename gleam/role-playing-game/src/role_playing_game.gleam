import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health, player.level {
    0, lv if lv >= 10 -> Some(Player(..player, health: 100, mana: Some(100)))
    0, _ -> Some(Player(..player, health: 100))
    _, _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    Some(mana) if mana >= cost -> #(
      Player(..player, mana: Some(mana - cost)),
      cost * 2,
    )
    None -> #(Player(..player, health: reduce_health(player.health, cost)), 0)
    _ -> #(player, 0)
  }
}

fn reduce_health(health: Int, damage: Int) -> Int {
  case health - damage {
    h if h < 0 -> 0
    h -> h
  }
}
