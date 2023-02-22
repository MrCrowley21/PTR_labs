defmodule WheelSupervisor do

  use Supervisor
  use GenServer
  require Logger

  def init(_args) do
    sensors = Enum.map(1..4, fn(n) ->
      Supervisor.child_spec(
        {Wheel, n},
        id: String.to_atom("wheel_#{n}"))
      end)
    # IO.inspect(workers)
    Logger.info("Wheels supervisor was created")
    Supervisor.init(sensors, strategy: :one_for_one, max_restarts: 2, max_seconds: 1000)
  end

  def start_link(_args) do
    Logger.info("Wheels supervisor was started")
    Supervisor.start_link(__MODULE__, [], name: :wheel_supervisor)
  end

  # def handle_cast({:check_wheels}, _state) do
  #   GenServer.cast(:wheel_1, {:check_wheel})
  #   GenServer.cast(:wheel_2, {:check_wheel})
  #   GenServer.cast(:wheel_3, {:check_wheel})
  #   GenServer.cast(:wheel_4, {:check_wheel})
  #   {:noreply, []}
  # end

  # def supervise_wheels() do
  #   GenServer.cast(:wheel_1, {:check_wheel})
  #   GenServer.cast(:wheel_2, {:check_wheel})
  #   GenServer.cast(:wheel_3, {:check_wheel})
  #   GenServer.cast(:wheel_4, {:check_wheel})
  # end

end
