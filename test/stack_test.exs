defmodule StackTest do
  use ExUnit.Case
  alias DataStructures.Stack

  describe "Stack creation" do
    test "Create empty stack" do
      assert %Stack{size: 0, data: []} = Stack.new()

      assert %Stack{size: 0, data: []} = Stack.new(nil)

      assert %Stack{size: 0, data: []} = Stack.new([])
    end

    test "Create stack with list" do
      stack = Stack.new([1, 2, 3])
      assert 3 == stack |> Stack.size()
    end
  end

  describe "Pushing values in to stack" do
    test "Pushing value in to stack" do
      assert 4 ==
               Stack.new()
               |> Stack.push(1)
               |> Stack.push(2)
               |> Stack.push(1)
               |> Stack.push(0)
               |> Stack.size()
    end
  end

  describe "Popping values from stack" do
    test "Popping value from stack" do
      {popped, stack} =
        Stack.new([1, 2, 3])
        |> Stack.pop()

      assert popped == 1
      assert 2 == stack |> Stack.size()
    end

    test "Popping value from empty stack" do
      assert {nil, _} =
               Stack.new()
               |> Stack.pop()
    end
  end

  describe "Testing size of stack" do
    test "size/0 should return valid value" do
      assert 3 == Stack.new([1, 2, 3]) |> Stack.size()
    end

    test "size/1 should return zero for nil stack" do
      assert 0 == Stack.size(nil)
    end
  end
end
