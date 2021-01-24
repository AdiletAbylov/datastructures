defmodule QueueTest do
  use ExUnit.Case
  alias DataStructures.Queue

  describe "Creation of queue" do
    test "Create empty queue" do
      assert %Queue{size: 0, data: []} = Queue.new()
      assert %Queue{size: 0, data: []} = Queue.new(nil)
      assert %Queue{size: 0, data: []} = Queue.new([])
    end

    test "Create queue with data" do
      queue = Queue.new([1, 2, 3])
      assert 3 == Queue.size(queue)
    end
  end

  describe "Pushing items in queue" do
    test "Push items and check size" do
      assert 3 ==
               Queue.new()
               |> Queue.push(1)
               |> Queue.push(1)
               |> Queue.push(1)
               |> Queue.size()
    end

    test "Push nil and size shouldn't be changed" do
      assert 3 ==
               Queue.new()
               |> Queue.push(1)
               |> Queue.push(1)
               |> Queue.push(nil)
               |> Queue.push(1)
               |> Queue.size()
    end
  end

  test "Popping item in queue" do
    assert {3, %Queue{data: [1, 2]}} = Queue.new([1, 2, 3]) |> Queue.pop()
    assert nil == Queue.new() |> Queue.pop()
    assert nil == Queue.pop(nil)
  end

  describe "Tests for size/1 and empty/1" do
    test "tests for size and empty" do
      assert 0 == Queue.size(nil)
      assert true == Queue.new() |> Queue.empty?()
      assert false == Queue.new([1, 2]) |> Queue.empty?()
    end
  end
end
