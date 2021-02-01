defmodule DataStructures.BST do
  @moduledoc """
  Implementation of binary search tree.
  """

  defstruct key: nil, value: nil, left: :empty, right: :empty

  @type t() :: %__MODULE__{
          key: integer() | nil,
          value: any() | nil,
          left: %__MODULE__{} | :empty,
          right: %__MODULE__{} | :empty
        }

  @doc """
  Returns empty BST struct with nil key and value, and empty child nodes.
  """
  @spec new :: DataStructures.BST.t()
  def new(), do: %__MODULE__{}

  @doc """
  Inserts key and value in to BST.
  If key is already in tree, updates it's value.
  Returns updated BST. Returns nil if given BST in nil.
  """
  @spec push(DataStructures.BST.t(), integer(), any) :: DataStructures.BST.t() | nil
  def push(nil, _, _), do: nil
  def push(bst, nil, _), do: bst
  def push(bst, _, nil), do: bst
  def push(%__MODULE__{} = bst, key, value), do: bst |> insert_under_node(key, value)

  @doc """
  Returns value of node found by the key.
  Returns `:not_found` if there is no such key in tree.
  Returns nil if given BST in nil.
  """
  @spec find_value(DataStructures.BST.t(), any) :: DataStructures.BST.t() | nil | :not_found
  def find_value(nil, _), do: nil
  def find_value(_, nil), do: :not_found

  def find_value(%__MODULE__{} = bst, key) do
    bst
    |> find_node(key)
    |> case do
      :not_found -> :not_found
      node -> Map.get(node, :value)
    end
  end

  @doc """
  Returns node of type `DataStructures.BST.t()` found by the key.
  Returns `:not_found` if there is no such key in tree.
  Returns nil if given BST in nil.
  """
  @spec find_node(DataStructures.BST.t(), any) :: DataStructures.BST.t() | nil | :not_found
  def find_node(nil, _), do: nil
  def find_node(_, nil), do: :not_found
  def find_node(%__MODULE__{} = bst, key), do: bst |> look_for_node(key)

  @doc """
  Returns value of minimal key in given tree or node.
  Returns nil if given BST in nil.
  """
  @spec min_value(DataStructures.BST.t()) :: any | nil
  def min_value(nil), do: nil

  def min_value(%__MODULE__{} = bst),
    do:
      bst
      |> minimum()
      |> Map.get(:value)

  @spec max_value(DataStructures.BST.t()) :: any | nil
  @doc """
  Returns value of maximal key in given tree or node.
  Returns nil if given BST in nil.
  """
  def max_value(nil), do: nil

  def max_value(%__MODULE__{} = bst),
    do:
      bst
      |> maximum()
      |> Map.get(:value)

  @doc """
  Removes node with the given key from tree. Read wiki https://en.wikipedia.org/wiki/Binary_search_tree to see how removing works.
  Returns updated tree.
  Returns nil if tree or key is nil.
  Returns unchanged tree if key not found.
  """
  @spec remove(DataStructures.BST.t(), any) :: DataStructures.BST.t()
  def remove(%__MODULE__{} = bst, key), do: bst |> delete_node_in(key)

  defp delete_node_in(%{key: key, left: left} = node, k) when k < key do
    case left do
      # stop search
      :empty -> node
      _ -> %{node | left: delete_node_in(left, k)}
    end
  end

  defp delete_node_in(%{key: key, right: right} = node, k) when k > key do
    case right do
      # stop search
      :empty -> node
      _ -> %{node | right: delete_node_in(right, k)}
    end
  end

  # if there are no childs, delete node
  defp delete_node_in(%{key: key, left: :empty, right: :empty}, k) when k == key,
    do: :empty

  # if there is left child, replace current node with the left child
  defp delete_node_in(%{key: key, left: left, right: :empty} = node, k) when k == key,
    do: %{node | key: left.key, value: left.value, left: :empty, right: :empty}

  # if there is right child, replace current node with the right child
  defp delete_node_in(%{key: key, left: :empty, right: right} = node, k) when k == key,
    do: %{node | key: right.key, value: right.value, left: :empty, right: :empty}

  # if there are two childs, do the black magic. See wikipedia to know how it works :)
  defp delete_node_in(%{key: key, left: _left, right: right} = node, k) when k == key do
    next = minimum(right)
    delete_node_in(node, next.key)
    %{node | key: next.key, value: next.value}
  end

  defp minimum(%{left: :empty} = node), do: node
  defp minimum(%{left: left}), do: minimum(left)

  defp maximum(%{right: :empty} = node), do: node
  defp maximum(%{right: right}), do: maximum(right)

  defp look_for_node(:empty, _), do: :not_found
  defp look_for_node(%{key: key} = node, k) when key == k, do: node
  defp look_for_node(%{key: key}, _) when is_nil(key), do: nil
  defp look_for_node(%{key: key, left: left}, k) when k < key, do: look_for_node(left, k)
  defp look_for_node(%{key: key, right: right}, k) when k > key, do: look_for_node(right, k)

  defp insert_under_node(%{key: key}, new_key, new_value) when key == nil,
    do: new_node(new_key, new_value)

  defp insert_under_node(%{key: key} = node, new_key, value) when new_key == key,
    do: %{node | value: value}

  defp insert_under_node(%{key: key, left: left} = node, new_key, value)
       when new_key < key do
    left
    |> case do
      :empty -> %{node | left: new_node(new_key, value)}
      _ -> %{node | left: insert_under_node(left, new_key, value)}
    end
  end

  defp insert_under_node(%{key: key, right: right} = node, new_key, value)
       when new_key > key do
    right
    |> case do
      :empty -> %{node | right: new_node(new_key, value)}
      _ -> %{node | right: insert_under_node(right, new_key, value)}
    end
  end

  defp new_node(key, value), do: %__MODULE__{key: key, value: value}
end
