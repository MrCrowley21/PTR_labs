defmodule FIFOQueue do

### Main Task ###
# Create an actor which maintains a simple FIFO queue. You should write helper
# functions to create an API for the user, which hides how the queue is implemented.

def new_queue() do
  spawn(__MODULE__, :resolve_queue, [[]])
end

def push(pid, value) do
  send(pid, {:push, value})
end

def pop(pid) do
  send(pid, {:pop})
end

def resolve_queue(list) do
  receive do
    {:push, value} ->
      list = list ++ [value]
      resolve_queue(list)
    {:pop} ->
      element = List.last(list)
      IO.inspect("#{element}")
      resolve_queue(List.delete_at(list, length(list) - 1))
  end
end

end
