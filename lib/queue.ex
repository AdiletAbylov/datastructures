defmodule DataStructures.Queue do
  @moduledoc """
  Queue implementation module.
  """
  defstruct data: [], size: 0

  @type t :: %__MODULE__{
          data: list(),
          size: non_neg_integer()
        }

  @doc """
  Returns empty queue struct of type  DataStructures.Queue.t().
  """
  @spec new :: DataStructures.Queue.t()
  def new(), do: %__MODULE__{}

  @doc """
  Returns queue with filled with data from a given list. If list in empty or nil, returns empty queue.
  """
  @spec new([any]) :: DataStructures.Queue.t()
  def new([]), do: new()
  def new(nil), do: new()
  def new(list) when is_list(list), do: %__MODULE__{data: list, size: length(list)}

  @doc """
  Pushes item in to the queue and returns updated queue. If queue in nil, returns nil.
  If item is nil returns unmodified queue.
  """
  @spec push(DataStructures.Queue.t(), any) :: DataStructures.Queue.t()
  def push(nil, _), do: nil
  def push(queue, nil), do: queue

  def push(%__MODULE__{data: list, size: size} = queue, item) do
    queue = %{queue | data: [item | list]}
    queue = %{queue | size: size + 1}
    queue
  end

  @doc """
  Pops item from queue and returns it in tuple with the updated queue.
  Returns nil if queue is nil or if queue is empty.
  """
  @spec pop(DataStructures.Queue.t()) :: {any, DataStructures.Queue.t()}
  def pop(nil), do: nil
  def pop(%__MODULE__{data: []}), do: nil

  def pop(%__MODULE__{data: list, size: size} = queue) do
    [popped | tail] = list |> :lists.reverse()
    queue = %{queue | size: size - 1}
    queue = %{queue | data: tail |> :lists.reverse()}
    {popped, queue}
  end

  @doc """
  Returns true if queue's size is 0.
  """
  @spec empty?(DataStructures.Queue.t()) :: boolean
  def empty?(%__MODULE__{size: size}), do: size == 0

  @doc """
  Returns size of queue. Returns 0 if queue is nil.
  """
  @spec size(DataStructures.Queue.t()) :: non_neg_integer()
  def size(nil), do: 0
  def size(%__MODULE__{size: size}), do: size
end
