defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp count([_head | tail], count), do: count(tail, count + 1)

  defp count([], count), do: count

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  defp reverse([head | tail], reversed_list) do
    reverse(tail, [head | reversed_list])
  end

  defp reverse([], reversed_list), do: reversed_list

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for n <- l, do: f.(n)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    for n <- l, f.(n), do: n
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([hd | tail], acc, f) do
    reduce(tail, f.(hd, acc), f)
  end

  def reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append(a, b) do
    reduce(reverse(a), b, fn n, acc -> [n | acc] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], &append(&2, &1))
  end
end
