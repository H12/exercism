defmodule SecretHandshake do
  use Bitwise, operators_only: true

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do

    wink([], code)
    |> double_blink(code)
    |> close_eyes(code)
    |> jump(code)
    |> reverse(code)
  end

  defp wink(handshake, code) do
    cond do
      (code &&& 1) == 1
        -> handshake ++ ["wink"]
      true
        -> handshake
    end
  end

  defp double_blink(handshake, code) do
    cond do
      (code &&& 2) == 2
        -> handshake ++ ["double blink"]
      true
        -> handshake
    end
  end

  defp close_eyes(handshake, code) do
    cond do
      (code &&& 4) == 4
        -> handshake ++ ["close your eyes"]
      true
        -> handshake
    end
  end

  defp jump(handshake, code) do
    cond do
      (code &&& 8) == 8
        -> handshake ++ ["jump"]
      true
        -> handshake
    end
  end

  defp reverse(handshake, code) do
    cond do
      (code &&& 16) == 16
        -> Enum.reverse(handshake)
      true
        -> handshake
    end
  end
end
