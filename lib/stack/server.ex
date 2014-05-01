defmodule Stack.Server do
  use GenServer.Behaviour

  def init(list) do
    { :ok, list }
  end

  def handle_call(:pop, _from, list) do
    [head | tail] = list
    { :reply, head, tail }
  end

end
