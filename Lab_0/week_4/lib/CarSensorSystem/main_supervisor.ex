defmodule MainSupervisor do

  ### Bonus Task ###

  # Write a supervised application that would simulate a sensor system in a car.
  # There should be sensors for each wheel, the motor, the cabin and the chassis. If any sensor dies
  # because of a random invalid measurement, it should be restarted. If, however, the main sensor
  # supervisor system detects multiple crashes, it should deploy the airbags. A possible supervision
  # tree is attached below.

  use Supervisor
  use Application
  require Logger

  def start(_type, _args) do
    # Application.put_env(:main_supervisor, :init_stop, [{Airbag, :on_stop, []}])
    Logger.info("Starting the app...")
    start_link()
  end

  def init(_args) do
    sensors = [
      Supervisor.child_spec(MotorSensor, id: :motor),
      Supervisor.child_spec(CabinSensor, id: :cabin),
      Supervisor.child_spec(ChassisSensor, id: :chassis),
      Supervisor.child_spec(WheelSupervisor, id: :wheel_supervisor),
      ]
    Logger.info("Sensors were created")
    Supervisor.init(sensors, strategy: :one_for_one, max_restarts: 2, max_seconds: 100)
  end

  def start_link() do
    Logger.info("Sensors were started")
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def supervise_car() do
    GenServer.cast(:motor, {:check_motor})
    GenServer.cast(:cabin, {:check_cabin})
    GenServer.cast(:chassis, {:check_chassis})
    # GenServer.cast(:wheel_supervisor, {:check_wheels})
    GenServer.cast(:wheel_1, {:check_wheel})
    GenServer.cast(:wheel_2, {:check_wheel})
    GenServer.cast(:wheel_3, {:check_wheel})
    GenServer.cast(:wheel_4, {:check_wheel})
  end

  end
