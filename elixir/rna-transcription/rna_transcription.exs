defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &map_nucleotide/1)
  end

  defp map_nucleotide(?G), do: ?C
  defp map_nucleotide(?C), do: ?G
  defp map_nucleotide(?T), do: ?A
  defp map_nucleotide(?A), do: ?U
end
