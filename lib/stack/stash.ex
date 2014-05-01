defmodule Stack.Stash do
  use GenServer.Behaviour

  #####
  # Public API

  def start_link(list) do
    :gen_server.start_link(__MODULE__, list, [])
  end

  def set_value(pid, value) do
    :gen_server.cast pid, { :set_value, value }
  end

  def get_value(pid) do
    :gen_server.call pid, :get_value
  end

  #####
  # GenServer implementation

  def init(list)
  when is_list(list) do
    {:ok, list}
  end

  def handle_call(:get_value, _from, current_value) do
    { :reply, current_value, current_value }
  end

  def handle_cast({:set_value, value}, _current_value) do
    { :noreply, value }
  end

end
