defmodule PRTTest do
  use ExUnit.Case
  doctest PRT

  test "greets the world" do
    assert PRT.hello() == :world
  end
end
