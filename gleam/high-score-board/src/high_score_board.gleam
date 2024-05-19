import gleam/dict.{type Dict}
import gleam/option.{type Option, None, Some}

pub type ScoreBoard =
  Dict(String, Int)

pub fn create_score_board() -> ScoreBoard {
  dict.new()
  |> dict.insert("The Best Ever", 1_000_000)
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  dict.insert(into: score_board, for: player, insert: score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  dict.delete(from: score_board, delete: player)
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  case dict.get(score_board, player) {
    Ok(score) -> dict.insert(score_board, player, score + points)
    Error(_) -> score_board
  }
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  dict.map_values(score_board, fn(_player: String, score: Int) -> Int {
    score + 100
  })
}
