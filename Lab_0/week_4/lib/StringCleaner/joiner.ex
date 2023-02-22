defmodule Joiner do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :joiner)
  end

  def init(_args) do
    Logger.info("Joiner is initialized")
    {:ok, []}
  end

  def handle_call({:join, input_list}, _from, _state) do
    Logger.info("Replaced list received")
    joined_list = Enum.join(input_list, " ")
    Logger.info("Current string form: #{joined_list}")
    {:reply, joined_list, []}
  end

  def handle_call({:kill}, _from, _state) do
    Logger.info("I am killed")
    Process.exit(self(), :died)
  end

end
