defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown_string) do
    markdown_string
    |> String.split("\n")
    |> Enum.map(&parse_line(&1))
    |> Enum.join()
    |> wrap_list_elements
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> parse_words()
    |> wrap_content_with_tag()
  end

  defp wrap_content_with_tag({tag, content}), do: "<#{tag}>#{content}</#{tag}>"

  defp parse_words(["*" | content]), do: {"li", join_words_with_tags(content)}
  defp parse_words(["#" | content]), do: {"h1", join_words_with_tags(content)}
  defp parse_words(["##" | content]), do: {"h2", join_words_with_tags(content)}
  defp parse_words(["###" | content]), do: {"h3", join_words_with_tags(content)}
  defp parse_words(["####" | content]), do: {"h4", join_words_with_tags(content)}
  defp parse_words(["#####" | content]), do: {"h5", join_words_with_tags(content)}
  defp parse_words(["######" | content]), do: {"h6", join_words_with_tags(content)}
  defp parse_words(content), do: {"p", join_words_with_tags(content)}

  defp join_words_with_tags(words) do
    words
    |> Enum.map(&add_inline_tags(&1))
    |> Enum.join(" ")
  end

  defp add_inline_tags(word) do
    word
    |> String.replace_prefix("___", "<em><strong>")
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_prefix("_", "<em>")
    |> String.replace_suffix("___", "</strong></em>")
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_suffix("_", "</em>")
  end

  defp wrap_list_elements(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
