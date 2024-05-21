import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(value: Float)
  Fahrenheit(value: Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

fn temperature_to_celsius(t: Temperature) -> Temperature {
  case t {
    Celsius(_) -> t
    Fahrenheit(f) -> Celsius(fahrenheit_to_celsius(f))
  }
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  float.compare(
    temperature_to_celsius(left).value,
    temperature_to_celsius(right).value,
  )
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, by: compare_city_temperature)
}

fn compare_city_temperature(left: City, right: City) -> Order {
  compare_temperature(left.temperature, right.temperature)
}
