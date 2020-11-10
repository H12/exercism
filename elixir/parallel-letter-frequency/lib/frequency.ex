defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    # TODO: Figure out workers
    Enum.reduce(texts, %{}, &accumulate_text/2)
  end

  defp accumulate_text(string, acc) do
    string
    |> String.downcase()
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.filter(&String.match?(&1, ~r/^[[:lower:]]+$/u))
    |> Enum.frequencies()
    |> Map.merge(acc, fn _key, new_count, acc_count -> new_count + acc_count end)
  end
end
