defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> apply_discount(discount)
    |> monthly_rate()
    |> ceil()
  end

  defp monthly_rate(hourly_rate), do: 22 * daily_rate(hourly_rate)

  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> apply_discount(discount)
    |> daily_rate()
    |> days_at_rate(budget)
  end

  defp days_at_rate(rate, budget), do: Float.floor(budget / rate, 1)
end
