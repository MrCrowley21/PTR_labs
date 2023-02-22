defmodule ChassisSensor do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :chassis)
  end

  def init(_args) do
    Logger.info("Chassis is initialized")
    {:ok, []}
  end

  def handle_cast({:check_chassis}, _state) do
    check_parameters()
    {:noreply, []}
  end

  def check_parameters() do
    if :rand.uniform(7) != 1 do
      Logger.info("Chassis is fine")
      check_parameters()
    else
      Logger.info("Chassis is broken")
      Process.exit(self(), :died)
    end
  end

end
