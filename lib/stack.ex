defmodule DataStructures.Stack do
  @moduledoc """
  Implementation of stack data structure.
  Stack struct contains size of stack field and data containing field.
  """

  defstruct size: 0, data: []

  @type t :: %__MODULE__{
          size: non_neg_integer(),
          data: list()
        }

  @doc """
  Returns empty stack structure of type DataStructures.Stack.t()
  """
  @spec new :: DataStructures.Stack.t()
  def new(), do: %__MODULE__{}

  @doc """
  Returns stack structure from the given list. If given list is empty or nil, returns empty stack.
  """
  @spec new([any]) :: DataStructures.Stack.t()
  def new([]), do: new()
  def new(nil), do: new()
  def new(items) when is_list(items), do: %__MODULE__{size: length(items), data: items}

  @doc """
  Returns size of stack. Returns 0 if stack is nil.
  """
  @spec size(DataStructures.Stack.t()) :: non_neg_integer()
  def size(nil), do: 0
  def size(%__MODULE__{size: size}), do: size

  @doc """
  Returns tuple with popped first element of the stack and chainged stack.
  If stack empty returns nil for popped element and stack.
  """
  @spec pop(DataStructures.Stack.t()) :: {any, DataStructures.Stack.t()}
  def pop(%__MODULE__{size: size} = stack) when size == 0, do: {nil, stack}

  def pop(%__MODULE__{size: size, data: data} = stack) do
    stack = %{stack | size: size - 1}
    {popped, tail} = pop_list(data)
    {popped, %{stack | data: tail}}
  end

  @doc """
  Pushes item in to the stack. Returns updated stack.
  """
  @spec push(DataStructures.Stack.t(), any) :: DataStructures.Stack.t()
  def push(%__MODULE__{size: size, data: data} = stack, item) do
    stack = %{stack | size: size + 1}
    %{stack | data: push_list(data, item)}
  end

  defp pop_list([]), do: nil
  defp pop_list([head | tail]), do: {head, tail}

  defp push_list(list, item), do: [item | list]
end
