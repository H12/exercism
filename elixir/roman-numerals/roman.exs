defmodule Roman do
  @numeral_pairs %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    {_number, conversion} = @numeral_pairs
    |> Enum.sort(&(&1 >= &2))
    |> Enum.reduce({number, ""}, &Roman.reduce_numeral/2)

    conversion
  end

  def reduce_numeral({value, numeral}, {number, conversion}) do
    multiple = div(number, value)
    new_number = number - (value * multiple)
    new_conversion = conversion <> String.duplicate(numeral, multiple)

    {new_number, new_conversion}
  end
end
