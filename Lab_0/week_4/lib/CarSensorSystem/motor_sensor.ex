defmodule MotorSensor do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :motor)
  end

  def init(_args) do
    Logger.info("Motor is initialized")
    {:ok, []}
  end

  def handle_cast({:check_motor}, _state) do
    check_parameters()
    {:noreply, []}
  end

  def check_parameters() do
    if :rand.uniform(3) != 1 do
      Logger.info("Motor is fine")
      check_parameters()
    else
      Logger.info("Mottor is broken")
      Process.exit(self(), :died)
    end
  end

end
