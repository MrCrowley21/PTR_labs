defmodule Supervised do

### Bonus Task ###
### Worker ###

# Create a module that would perform some risky business. Start by creating a
# scheduler actor. When receiving a task to do, it will create a worker node that will perform the
# task. Given the nature of the task, the worker node is prone to crashes (task completion rate
# 50%). If the scheduler detects a crash, it will log it and restart the worker node. If the worker
# node finishes successfully, it should print the result.

def startLink(superviser) do
  pid = spawn_link(__MODULE__, :doAction, [superviser])
  Process.register(pid, :supervised)
  pid
end

def doAction(supervisor) do
  if :rand.uniform(2) == 1 do
    exit(:normal)
  else
    IO.puts("This is worker. I am done.")
    send(supervisor, {:completed})
  end
end

end
