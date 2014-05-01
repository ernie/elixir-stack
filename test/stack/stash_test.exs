defmodule StashTest do
  use ExUnit.Case

  import Stack.Stash, only: [
      start_link: 1,
      set_value: 2,
      get_value: 1
    ]

  test "start_link starts the application" do
    {:ok, pid} = start_link(["cat"])
    assert pid
  end

  test "set_value sets the value" do
    {:ok, pid} = start_link(["cat"])
    assert set_value(pid, ["dog"]) == :ok
  end

  test "get_value gets the value" do
    {:ok, pid} = start_link(["cat"])
    assert get_value(pid) == ["cat"]
  end

end
