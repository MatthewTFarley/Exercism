defmodule FreelancerRates do
  @daily_rate_factor 8.0
  @monthly_billable_days 22

  def daily_rate(hourly_rate) do
    hourly_rate * @daily_rate_factor
  end

  def apply_discount(before_discount, discount) do
    before_discount - calculate_discount(before_discount, discount)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> calculate_monthly_total
    |> apply_discount(discount)
    |> ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> apply_discount(discount)
    |> then(&(budget / &1))
    |> Float.floor(1)
  end

  defp calculate_discount(before_discount, discount) do
    before_discount * percent_to_decimal(discount)
  end

  defp percent_to_decimal(percent) do
    percent * 0.01
  end

  defp calculate_monthly_total(daily_rate) do
    daily_rate * @monthly_billable_days
  end
end
