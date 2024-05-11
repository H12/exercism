import gleam/list
import gleam/pair

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  pair.swap(place_location)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  treasure_location == place_location_to_treasure_location(place_location)
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let treasure_location = place_location_to_treasure_location(place.1)

  treasures
  |> list.map(pair.second)
  |> list.filter(fn(location) { location == treasure_location })
  |> list.length
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case
    pair.first(found_treasure),
    pair.first(desired_treasure),
    pair.first(place)
  {
    "Brass Spyglass", _, "Abandoned Lighthouse" -> True
    "Amethyst Octopus", "Crystal Crab", "Stormy Breakwater"
    | "Amethyst Octopus", "Glass Starfish", "Stormy Breakwater" -> True
    "Vintage Pirate Hat", "Model Ship in Large Bottle", "Harbor Managers Office"
    | "Vintage Pirate Hat",
      "Antique Glass Fishnet Float",
      "Harbor Managers Office" -> True
    _, _, _ -> False
  }
}
