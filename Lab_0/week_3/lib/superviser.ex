defmodule Superviser do

### Bonus Task ###
### Supervisor ###

# Create a module that would perform some risky business. Start by creating a
# scheduler actor. When receiving a task to do, it will create a worker node that will perform the
# task. Given the nature of the task, the worker node is prone to crashes (task completion rate
# 50%). If the scheduler detects a crash, it will log it and restart the worker node. If the worker
# node finishes successfully, it should print the result.

def create_scheduler() do
  spawn(__MODULE__, :receive_task, [])
end

def receive_task() do
  receive do
    {:new_task} -> supervise()
  end
  receive_task()
end

def supervise() do
  supervisor = self()
  pid =
    spawn(fn ->
      if :rand.uniform(2) == 1 do
        Process.exit(self(), :fail)
      else
        IO.puts("This is worker. I am done.")
        send(supervisor, {:completed})
      end
    end)
  _ref = Process.monitor(pid)
  receive do
    {:completed} ->
      IO.puts("The worker solved its task!")
    {:DOWN, _ref, :process, _object, :fail} ->
      IO.puts("Worker failed. Restarting it...")
      supervise()
  end
end

end
