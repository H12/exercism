defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers)

  def frequency([], _workers), do: %{}

  def frequency(texts, workers) do
    combined_text = Enum.reduce(texts, "", &(&1 <> &2))

    text_length = byte_size(combined_text)
    divisor = ceil(text_length / workers)

    Regex.scan(~r/[[:alpha:]]/u, combined_text)
    |> List.flatten()
    |> Enum.chunk_every(divisor)
    |> Enum.map(&frequency_task/1)
    |> Enum.map(fn task -> Task.await(task) end)
    |> Enum.reduce(%{}, &merge_frequencies(&2, &1))
  end

  defp frequency_task(codepoints) do
    Task.async(fn -> Enum.frequencies_by(codepoints, &String.downcase/1) end)
  end

  defp merge_frequencies(frequency, other_frequency) do
    Map.merge(
      frequency,
      other_frequency,
      fn _key, new_count, acc_count -> new_count + acc_count end
    )
  end
end
