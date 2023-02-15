defmodule Monitored do

### Minimal Task ###
# Create a two actors, actor one ”monitoring” the other. If the second actor
# stops, actor one gets notified via a message.

# Monitored actor

def startLink do
  pid = spawn_link(__MODULE__, :doAction, [])
  Process.register(pid, :monitored)
  pid
end

def doAction() do
  receive do
    {:shutdown} -> exit(:normal)
    message -> IO.puts("Alive")
  end
  doAction()
end

end
