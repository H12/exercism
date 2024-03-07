pub fn expected_minutes_in_oven() -> Int {
  40
}

pub fn remaining_minutes_in_oven(minutes_in_oven: Int) -> Int {
  expected_minutes_in_oven() - minutes_in_oven
}

pub fn preparation_time_in_minutes(number_of_layers: Int) -> Int {
  number_of_layers * 2
}

pub fn total_time_in_minutes(number_of_layers: Int, minutes_in_oven: Int) -> Int {
  preparation_time_in_minutes(number_of_layers) + minutes_in_oven
}

pub fn alarm() -> String {
  "Ding!"
}
