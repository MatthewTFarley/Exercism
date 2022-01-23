defmodule LibraryFees do
  @days_in_seconds 60 * 60 * 24

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime).hour < 12
  end

  def return_date(checkout_datetime) do
    rental_period =
      if before_noon?(checkout_datetime) do
        28
      else
        29
      end * @days_in_seconds

    checkout_datetime
    |> NaiveDateTime.add(rental_period, :second)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned, actual) do
    actual
    |> Date.diff(planned)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    return
    |> datetime_from_string()
    |> then(fn return_date ->
      if(monday?(return_date), do: rate / 2, else: rate)
      |> then(fn rate ->
        checkout
        |> datetime_from_string()
        |> return_date()
        |> days_late(return_date)
        |> Kernel.*(rate)
        |> trunc()
      end)
    end)
  end
end
