defmodule Semaphore do

### Main Task ###
# Create a module that would implement a semaphore.

def create_semaphore(counter) do
  spawn(__MODULE__, :resolve_semaphore, [counter, counter])
end

def acquire(pid) do
  send(pid, {:new_request, self()})
  receive do
    {state} ->
      state
  end
end

def release(pid) do
  send(pid, {:is_released})
end

def resolve_semaphore(counter, max_value) when counter == max_value do
  receive do
    {:is_released} ->
      resolve_semaphore(counter, max_value)
    {:new_request, sender} ->
      send(sender, {:is_allowed})
      resolve_semaphore(counter - 1, max_value)
  end
end

def resolve_semaphore(counter, max_value) when counter > 0 do
  receive do
    {:is_released} ->
      resolve_semaphore(counter + 1, max_value)
    {:new_request, sender} ->
      send(sender, {:is_allowed})
      resolve_semaphore(counter - 1, max_value)
  end
end

def resolve_semaphore(0, max_value) do
  receive do
    {:is_released} ->
      resolve_semaphore(1, max_value)
    {:new_request, sender} ->
      send(sender, {:is_blocked})
      resolve_semaphore(0, max_value)
  end
end

end
