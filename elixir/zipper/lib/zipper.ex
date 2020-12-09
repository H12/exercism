defmodule Zipper do
  defstruct tree: nil, history: []

  @type t() :: %__MODULE__{}

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %__MODULE__{tree: bin_tree}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(zipper) do
    zipper.tree
  end

  defp get_focus(zipper) do
    zipper.history
    |> Enum.reverse()
    |> Enum.reduce(zipper.tree, &Map.get(&2, &1))
  end

  defp traversal_path(zipper) do
    zipper.history
    |> Enum.reverse()
    |> Enum.map(&Access.key/1)
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    get_focus(zipper).value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(zipper) do
    with %BinTree{left: left} <- get_focus(zipper),
         %BinTree{} <- left do
      %__MODULE__{tree: zipper.tree, history: [:left | zipper.history]}
    else
      _ -> nil
    end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper) do
    with %BinTree{right: right} <- get_focus(zipper),
         %BinTree{} <- right do
      %__MODULE__{tree: zipper.tree, history: [:right | zipper.history]}
    else
      _ -> nil
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(zipper)

  def up(%__MODULE__{tree: tree, history: []}), do: nil

  def up(zipper) do
    Map.put(zipper, :history, tl(zipper.history))
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    update_focus(zipper, :value, value)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    update_focus(zipper, :left, left)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    update_focus(zipper, :right, right)
  end

  defp update_focus(zipper, key, value) do
    new_focus =
      zipper
      |> get_focus()
      |> Map.put(key, value)

    new_tree = update_tree(zipper.tree, traversal_path(zipper), new_focus)

    Map.put(zipper, :tree, new_tree)
  end

  defp update_tree(tree, [], sub_tree), do: sub_tree
  defp update_tree(tree, path, sub_tree), do: put_in(tree, path, sub_tree)
end
