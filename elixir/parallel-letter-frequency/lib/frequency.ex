defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    combined_text = Enum.reduce(texts, "", &(&1 <> &2))
    text_length = byte_size(combined_text)

    if text_length == 0 do
      %{}
    else
      divisor = ceil(text_length / workers)

      combined_text
      |> String.codepoints()
      |> Enum.chunk_every(divisor)
      |> Enum.map(&Enum.join/1)
      |> Enum.map(fn text -> Task.async(fn -> accumulate_text(text) end) end)
      |> Enum.map(fn task -> Task.await(task) end)
      |> Enum.reduce(%{}, &merge_frequencies(&2, &1))
    end
  end

  defp accumulate_text(string) do
    string
    |> String.downcase()
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.filter(&String.match?(&1, ~r/^[[:lower:]]+$/u))
    |> Enum.frequencies()
  end

  defp merge_frequencies(frequency, other_frequency) do
    Map.merge(
      frequency,
      other_frequency,
      fn _key, new_count, acc_count -> new_count + acc_count end
    )
  end
end
