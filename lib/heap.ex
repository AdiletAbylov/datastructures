defmodule DataStructures.Heap do
  @moduledoc """
  Implementation of max Heap data structure. Based on Map as data representation. Why Map?
  Because most of the List functions performs in linear time.
  And Map functions in most cases perfoms in logarithmic time.
  """
  defstruct size: 0, data: %{}

  @type t :: %__MODULE__{
          size: non_neg_integer(),
          data: map()
        }

  @doc """
  Returns empty heap.
  """
  @spec new :: DataStructures.Heap.t()
  def new(), do: %__MODULE__{}

  @doc """
  Returns heap with elements from list.
  Returns empty heap if argument is nil, empty list or not list.
  """
  @spec new(nil | maybe_improper_list) :: DataStructures.Heap.t() | nil
  def new([]), do: new()
  def new(nil), do: new()

  def new(list) when is_list(list),
    do:
      list
      |> Enum.reduce(new(), &push(&2, &1))

  def new(_), do: new()

  @doc """
  Inserts value in to the heap. Sorts heap after inserting.
  Returns heap containing inserted value.
  Returns nil if heap  argument is nil.
  Returns unchanged heap if inserting value is nil.
  """
  @spec push(DataStructures.Heap.t(), any) :: DataStructures.Heap.t() | nil
  def push(%__MODULE__{size: size, data: data}, value) do
    parent_index = parent_index_for(size)

    %__MODULE__{
      size: size + 1,
      data:
        data
        |> Map.put(size, value)
        |> siftUp(size, parent_index, value, Map.get(data, parent_index))
    }
  end

  def push(nil, _), do: nil
  def push(heap, nil), do: heap

  @doc """
  Returns maximum element from heap. Returns tuple with maximum lement value and resorted heap.
  Returns nil if heap is empty.
  Returns nil if heap argument is nil.
  """
  @spec pop_max(DataStructures.Heap.t()) :: {any, DataStructures.Heap.t()} | nil
  def pop_max(%__MODULE__{size: size}) when size == 0, do: nil

  def pop_max(%__MODULE__{size: size, data: %{0 => max} = data}) do
    {
      max,
      %__MODULE__{
        size: size - 1,
        data:
          data
          |> swap_values(0, size - 1)
          |> Map.delete(size - 1)
          |> siftDown(size - 1, 0, left_index_for(0), right_index_for(0))
      }
    }
  end

  def pop_max(nil), do: nil

  @doc """
  Returns sorted list of elements in heap.
  Returns empty list if heap is nil or empty.
  """
  @spec to_list(DataStructures.Heap.t()) :: [any]
  def to_list(nil), do: []
  def to_list(%__MODULE__{size: size}) when size == 0, do: []
  def to_list(heap), do: heap |> sortedList([])

  defp sortedList(heap, list) do
    heap
    |> pop_max()
    |> case do
      nil -> list |> Enum.reverse()
      {max, new_heap} -> sortedList(new_heap, [max | list])
    end
  end

  defp siftUp(data, i, parent_index, value, parent_value) when i > 0 and value > parent_value do
    new_parent_index = parent_index_for(parent_index)

    data
    |> swap_values(i, parent_index)
    |> siftUp(
      parent_index,
      new_parent_index,
      value,
      Map.get(data, new_parent_index)
    )
  end

  defp siftUp(data, _, _, _, _), do: data

  defp siftDown(data, size, position, left_index, right_index) do
    position
    |> largest_index_from(left_index, data)
    |> largest_index_from(right_index, data)
    |> case do
      largest_index when largest_index == position ->
        data

      largest_index when largest_index < size ->
        data
        |> swap_values(position, largest_index)
        |> siftDown(
          size,
          largest_index,
          left_index_for(largest_index),
          right_index_for(largest_index)
        )

      _ ->
        data
    end
  end

  defp largest_index_from(largest_index, child_index, data) do
    with value_largest when not is_nil(value_largest) <- Map.get(data, largest_index),
         value_child when not is_nil(value_largest) <- Map.get(data, child_index) do
      if value_child > value_largest, do: child_index, else: largest_index
    else
      _ -> largest_index
    end
  end

  defp parent_index_for(i), do: div(i - 1, 2)
  defp left_index_for(i), do: 2 * i + 1
  defp right_index_for(i), do: 2 * i + 2

  defp swap_values(data, i, j) do
    with value_i <- Map.get(data, i), value_j <- Map.get(data, j) do
      data
      |> Map.put(j, value_i)
      |> Map.put(i, value_j)
    end
  end
end
