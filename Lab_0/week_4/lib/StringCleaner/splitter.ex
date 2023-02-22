defmodule Splitter do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :splitter)
  end

  def init(_args) do
    Logger.info("Splitter is initialized")
    {:ok, []}
  end

  def handle_call({:split, input_string}, _from, _state) do
    Logger.info("New messed string received")
    splitted_string = String.split(input_string, " ")
    Logger.info("Current string form: #{splitted_string}")
    {:reply, splitted_string, []}
  end

  def handle_call({:kill}, _from, _state) do
    Logger.info("I am killed")
    Process.exit(self(), :died)
  end

end
