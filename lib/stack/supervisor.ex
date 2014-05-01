defmodule Stack.Supervisor do
  use Supervisor.Behaviour

  def start_link(list) do
    result = {:ok, sup} = :supervisor.start_link(__MODULE__, list)
    start_workers(sup, list)
    result
  end

  def start_workers(sup, list) do
    {:ok, stash} = :supervisor.start_child(sup, worker(Stack.Stash, [list]))
    :supervisor.start_child(sup, worker(Stack.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end
