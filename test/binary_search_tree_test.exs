defmodule BSTTest do
  use ExUnit.Case
  alias DataStructures.BST

  test "Find elements tests" do
    bst =
      BST.new()
      |> BST.push(20, "A")
      |> BST.push(1, "B")
      |> BST.push(13, "C")
      |> BST.push(10, "D")
      |> BST.push(2, "E")
      |> BST.push(5, "F")

    assert %{key: 10, value: "D"} = bst |> BST.find_node(10)
    assert "F" == bst |> BST.find_value(5)
    assert :not_found == bst |> BST.find_value(100)
    assert "A" == bst |> BST.max_value()
    assert "B" == bst |> BST.min_value()
  end

  test "Removing elements tests" do
    bst =
      BST.new()
      |> BST.push(20, "A")
      |> BST.push(1, "B")
      |> BST.push(13, "C")
      |> BST.push(10, "D")
      |> BST.push(2, "E")
      |> BST.push(5, "F")
      |> BST.push(25, "G")

    assert :not_found ==
             bst
             |> BST.remove(10)
             |> BST.find_value(10)

    assert bst == bst |> BST.remove(100)
  end
end
