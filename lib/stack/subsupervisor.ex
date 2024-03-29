defmodule Stack.SubSupervisor do
  use Supervisor.Behaviour

  def start_link(stash_pid) do
    :supervisor.start_link(__MODULE__, stash_pid)
  end

  def init(stash_pid) do
    child_processes = [worker(Stack.Server, [stash_pid])]
    supervise(child_processes, strategy: :one_for_one)
  end

end
