defmodule SamuelLJackson do

  use Supervisor
  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Starting the app...")
    start_link()
  end

  def init(_args) do
    victims = [
      Supervisor.child_spec(PitfulGuy, id: :pitful_guy)
      ]
    Logger.info("The strange dude has been brought")
    Supervisor.init(victims, strategy: :one_for_one, max_restarts: 5, max_seconds: 200)
  end

  def start_link() do
    Logger.info("Everything prepared for 'discussion'")
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def ask_question(content) do
    GenServer.call(:pitful_guy, {:question, content})
  end

end
