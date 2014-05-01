defmodule Stack.Server do
  use GenServer.Behaviour

  #####
  # External API

  def start_link(stash_pid) do
    :gen_server.start_link({:local, :stack}, __MODULE__, stash_pid, [])
  end

  def pop do
    :gen_server.call(:stack, :pop)
  end

  def push(value) do
    :gen_server.cast(:stack, {:push, value})
  end

  #####
  # Genserver implementation

  def init(stash_pid) do
    list = Stack.Stash.get_value(stash_pid)
    { :ok, { stash_pid, list } }
  end

  def terminate(_reason, { stash_pid, list }) do
    Stack.Stash.set_value(stash_pid, list)
  end

  def handle_call(:pop, _from, { stash_pid, list }) do
    [head | tail] = list
    { :reply, head, { stash_pid, tail } }
  end

  def handle_cast({:push, new_value}, { stash_pid, list }) do
    { :noreply, { stash_pid, [new_value] ++ list } }
  end

end
