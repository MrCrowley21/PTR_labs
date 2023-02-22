defmodule PitfulGuy do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :pitful_guy)
  end

  def init(_args) do
    Logger.info("The pitful is scared as hell")
    {:ok, []}
  end

  def handle_call({:question, content}, _from, _state) do
    generate_answer()
  end

  def generate_answer() do
    if :rand.uniform(2) != 1 do
      Logger.info("He finally gives a statement as an answer")
      {:reply, :answer, []}
    else
      Logger.info("Pitful guy said 'What?' again...")
      Process.exit(self(), :threatened)
    end
  end

end
