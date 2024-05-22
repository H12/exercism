import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.contains(collection, card), set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let new_collection =
    collection
    |> set.delete(my_card)
    |> set.insert(their_card)

  #(
    set.contains(collection, my_card) && !set.contains(collection, their_card),
    new_collection,
  )
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  build_boring_cards(collections, set.new())
}

fn build_boring_cards(
  collections: List(Set(String)),
  borings: Set(String),
) -> List(String) {
  case collections {
    [first, next, ..rest] ->
      build_boring_cards(rest, set.intersection(first, next))
    [next, ..rest] -> build_boring_cards(rest, set.intersection(next, borings))
    [] -> set.to_list(borings)
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  set.size(build_total_cards(collections, set.new()))
}

fn build_total_cards(
  collections: List(Set(String)),
  total: Set(String),
) -> Set(String) {
  case collections {
    [next, ..rest] -> build_total_cards(rest, set.union(next, total))
    [] -> total
  }
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  set.filter(collection, fn(card: String) { string.starts_with(card, "Shiny ") })
}
