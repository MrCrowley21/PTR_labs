defmodule EchoSupervisor do

### Minimal Task ###

# Minimal Task Create a supervised pool of identical worker actors. The number of actors
# is static, given at initialization. Workers should be individually addressable. Worker actors
# should echo any message they receive. If an actor dies (by receiving a “kill” message), it should
# be restarted by the supervisor. Logging is welcome.

use Supervisor
require Logger

def init(nr_workers) do
  workers = Enum.map(1..nr_workers, fn(n) ->
    Supervisor.child_spec(
      {EchoWorker, n},
      id: String.to_atom("worker_#{n}"))
    end)
  # IO.inspect(workers)
  Logger.info("Workers were created")
  Supervisor.init(workers, strategy: :one_for_one)
end

def start_link(nr_workers) do
  Logger.info("Workers were started")
  Supervisor.start_link(__MODULE__, nr_workers, name: __MODULE__)
end

end
