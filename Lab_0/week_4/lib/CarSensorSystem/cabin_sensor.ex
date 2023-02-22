defmodule CabinSensor do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :cabin)
  end

  def init(_args) do
    Logger.info("Cabin is initialized")
    {:ok, []}
  end

  def handle_cast({:check_cabin}, _state) do
    check_parameters()
  end

  def check_parameters() do
    if :rand.uniform(5) != 1 do
      Logger.info("Cabine is fine")
      check_parameters()
    else
      Logger.info("Mottor is broken")
      Process.exit(self(), :died)
    end
  end

end
