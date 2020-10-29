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
    map(l, f, [])
  end

  defp map([head | tail], f, mapped_list) do
    map(tail, f, [f.(head) | mapped_list])
  end

  defp map([], _f, mapped_list), do: reverse(mapped_list)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  defp filter([hd | tail], f, filtered_list) do
    if f.(hd) do
      filter(tail, f, [hd | filtered_list])
    else
      filter(tail, f, filtered_list)
    end
  end

  defp filter([], _f, filtered_list), do: reverse(filtered_list)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([hd | tail], acc, f) do
    reduce(tail, f.(hd, acc), f)
  end

  def reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append(a, b) do
    prepend_reversed(reverse(a), b) |> reverse
  end

  defp prepend_reversed(new_list, [head | tail]) do
    prepend_reversed([head | new_list], tail)
  end

  defp prepend_reversed(new_list, []), do: new_list

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    concat(ll, [])
  end

  defp concat([head_list | tail_lists], concatenated_list) do
    concat(
      tail_lists,
      prepend_reversed(concatenated_list, head_list)
    )
  end

  defp concat([], concatenated_list), do: reverse(concatenated_list)
end
