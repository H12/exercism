defmodule Words do
  @symbols_and_punctuation ~r/[\p{Po}\p{S}]/u

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    String.downcase(sentence)
    |> String.replace("_", " ")
    |> String.replace(@symbols_and_punctuation, "")
    |> String.split
    |> Enum.group_by(fn string -> string end)
    |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
    |> Enum.into(%{})
  end
end
