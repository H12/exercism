defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: keep(list, fun, [])

  def keep([], _fun, acc), do: Enum.reverse(acc)

  def keep([head | tail], fun, acc) do
    if fun.(head) do
      keep(tail, fun, [head | acc])
    else
      keep(tail, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: discard(list, fun, [])

  def discard([], _fun, acc), do: Enum.reverse(acc)

  def discard([head | tail], fun, acc) do
    if fun.(head) do
      discard(tail, fun, acc)
    else
      discard(tail, fun, [head | acc])
    end
  end
end
