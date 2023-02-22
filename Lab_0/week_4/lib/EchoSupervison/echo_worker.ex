defmodule EchoWorker do

use GenServer
require Logger

def start_link(number) do
  GenServer.start_link(__MODULE__, [], name: String.to_atom("worker_#{number}"))
end

def init(list) do
  Logger.info("Worker is initialized")
  {:ok, list}
end

def handle_call({:echo, message}, _from, _state) do
  Logger.info("New echo message received")
  IO.puts(message)
  {:reply, :ok, []}
end

def handle_call({:kill}, _from, _state) do
  Logger.info("Soon I will be killed")
  Process.exit(self(), :died)
end

end
