pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  sum_pizza_extras(pizza, 0)
}

fn sum_pizza_extras(pizza: Pizza, total: Int) -> Int {
  case pizza {
    Margherita -> 7 + total
    Caprese -> 9 + total
    Formaggio -> 10 + total
    ExtraSauce(pizza) -> sum_pizza_extras(pizza, 1 + total)
    ExtraToppings(pizza) -> sum_pizza_extras(pizza, 2 + total)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  sum_pizza_prices(order, 0, 0)
}

fn sum_pizza_prices(order: List(Pizza), total: Int, count: Int) {
  case order {
    [] if count == 1 -> 3 + total
    [] if count == 2 -> 2 + total
    [] -> total
    [pizza, ..rest] ->
      sum_pizza_prices(rest, total + pizza_price(pizza), 1 + count)
  }
}
