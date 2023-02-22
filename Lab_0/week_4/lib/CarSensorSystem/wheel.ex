defmodule Wheel do

  use GenServer
  require Logger

  def start_link(number) do
    GenServer.start_link(__MODULE__, [], name: String.to_atom("wheel_#{number}"))
  end

  def init(_args) do
    Logger.info("Wheel is initialized")
    {:ok, []}
  end

  def handle_cast({:check_wheel}, _state) do
    check_parameters()
    {:noreply, []}
  end

  def check_parameters() do
    if :rand.uniform(4) != 1 do
      Logger.info("Wheel is fine")
      check_parameters()
    else
      Logger.info("Wheel is broken")
      Process.exit(self(), :died)
    end
  end

end
