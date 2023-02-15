defmodule Monitor do

### Minimal Task ###
# Create a two actors, actor one ”monitoring” the other. If the second actor
# stops, actor one gets notified via a message.

# Monitor actor

def start do
  pid = spawn(__MODULE__, :executeMonitor, [])
  pid
end

def monitor() do
  pid = Monitored.startLink()
  receive do
    {:EXIT, ^pid, reason} -> IO.puts("It stopped")
    monitor()
  end
  pid
end

def executeMonitor() do
  Process.flag(:trap_exit, true)
  monitor()
end

end
