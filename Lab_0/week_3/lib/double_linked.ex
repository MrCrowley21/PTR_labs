defmodule DoubleLinked do

### Bonus Task ###
# Create a module that would implement a doubly linked list where each node of
# the list is an actor.

# def start() do
#   spawn(__MODULE__, :resolve_dllist, [nil, nil, nil])
# end

def create_dllist(list) do
  pid = spawn(__MODULE__, :resolve_dllist, [nil, nil, nil])
  send(pid, {:actors, self(), nil, list})
  receive do
    {:ok} -> {:list_created}
  end
  pid
end

def resolve_dllist(node, prev, next) do
  receive do
    {:actors, pid, _pred, []} ->
      send(pid, {:ok})
      resolve_dllist(node, prev, nil)

    {:actors, pid, pred, [head|list]} ->
      actor = spawn(__MODULE__, :resolve_dllist, [head, pred, nil])
      send(actor, {:actors, pid, self(), list})
      resolve_dllist(node, prev, actor)

    {:traversed, pid, list} when node == nil ->
      send(next, {:traversed, pid, list})
      resolve_dllist(node, prev, next)

    {:traversed, pid, list} when next == nil->
      send(pid, {:ok, list ++ [node]})
      resolve_dllist(node, prev, next)

    {:traversed, pid, list} ->
      send(next, {:traversed, pid, list ++ [node]})
      resolve_dllist(node, prev, next)

    {:inverse, pid, list} when node == nil ->
      send(next, {:inverse, pid, list})
      resolve_dllist(node, prev, next)

    {:inverse, pid, list} when next == nil->
      send(pid, {:ok, [node] ++ list})
      resolve_dllist(node, prev, next)

    {:inverse, pid, list} ->
      send(next, {:inverse, pid, [node] ++ list})
      resolve_dllist(node, prev, next)
  end
end

def traverse(pid) do
  send(pid, {:traversed, self(), []})
  receive do
    {:ok, traversed_list} -> IO.inspect traversed_list, label: "Traversed list: "
  end
end

def inverse(pid) do
  send(pid, {:inverse, self(), []})
  receive do
    {:ok, inverse_list} -> IO.inspect inverse_list, label: "Inverse traversed list: "
  end
end

end
