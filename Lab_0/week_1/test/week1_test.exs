defmodule Week1Test do
  use ExUnit.Case
  doctest Week1

  test "greets the world" do
    assert Week1.hello() == "Hello PTR"
  end

  test "failure greeting" do
    assert Week1.hello() == "You're a failure"
  end
end
