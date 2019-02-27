defmodule Bob do
  def hey(input) do
    cond do
      (String.trim(input) |> String.length) == 0 ->
        "Fine. Be that way!"
      String.at(input, -1) == "?" ->
        cond do
          is_shouting(input) ->
            "Calm down, I know what I'm doing!"
          true ->
            "Sure."
         end
      is_shouting(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  def is_shouting(string) do
    Regex.match?(~r/\p{Lu}/, string) and !Regex.match?(~r/\p{Ll}/, string)
  end
end
