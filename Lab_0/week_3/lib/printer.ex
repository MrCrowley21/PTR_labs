defmodule Printer do

### Minimal Task ###

# Create an actor that prints on the screen any message it receives.

def printMessage() do
  receive do
    received_message -> IO.inspect("Received message: #{received_message}")
  end
  printMessage()
end

end
