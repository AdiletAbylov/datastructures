defmodule PriorityQueueTest do
  use ExUnit.Case
  alias DataStructures.PriorityQueue

  test "Test Priority Queue" do
    assert {12, "maximus"} ==
             PriorityQueue.new()
             |> PriorityQueue.push({1, "abc"})
             |> PriorityQueue.push({1, "ddd"})
             |> PriorityQueue.push({2, "abc"})
             |> PriorityQueue.push({12, "maximus"})
             |> PriorityQueue.pop()
             |> elem(0)
  end
end
