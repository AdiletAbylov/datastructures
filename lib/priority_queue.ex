defmodule DataStructures.PriorityQueue do
  @moduledoc """
  Implementation of priority queue based on DataStructures.Heap.
  """
  alias DataStructures.Heap
  defstruct heap: %Heap{}

  @type t() :: %__MODULE__{
          heap: Heap.t()
        }

  @doc """
  Returns empty queue.
  """
  @spec new :: DataStructures.PriorityQueue.t()
  def new(), do: %__MODULE__{}

  @doc """
  Inserts item in to queue and sorts queue.
  Returns updated queue.
  Returns nil for nil queue.
  Returns unchanged queue if item is nil.
  """
  @spec push(DataStructures.PriorityQueue.t(), any) :: DataStructures.PriorityQueue.t()
  def push(nil, _), do: nil
  def push(queue, nil), do: queue
  def push(%__MODULE__{heap: heap} = queue, item), do: %{queue | heap: Heap.push(heap, item)}

  @doc """
  Returns element form queue with the highest priority and updated queue.
  Returns nil for nil queue.
  """
  @spec pop(DataStructures.PriorityQueue.t()) :: nil | {any, DataStructures.Heap.t()}
  def pop(nil), do: nil
  def pop(%__MODULE__{heap: heap}), do: Heap.pop_max(heap)
end
