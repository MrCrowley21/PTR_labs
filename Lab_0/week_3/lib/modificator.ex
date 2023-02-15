defmodule Modificator do

### Minimal Task ###
# Create an actor that returns any message it receives, while modifying it.

def receiveMessage() do
  receive do
    n -> modifyMessage(n)
  end
  receiveMessage()
end

defp modifyMessage(n) do
  cond do
    is_integer(n) -> IO.inspect("Received: #{n + 1}")
    is_bitstring(n) -> IO.inspect("Received: #{String.downcase(n)}")
    true -> IO.inspect("Received: I don't know how to HANDLE this!")
  end
end

end
