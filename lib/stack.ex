defmodule Stack do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, list) do
    Stack.Supervisor.start_link(list)
  end
end
