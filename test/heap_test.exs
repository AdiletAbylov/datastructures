defmodule HeapTestuse do
  use ExUnit.Case
  alias DataStructures.Heap

  test "Heap sorting test" do
    assert [12, 9, 8, 6, 4, 3] ==
             [3, 6, 4, 9, 8, 12]
             |> Heap.new()
             |> Heap.to_list()
  end
end
