defmodule CarApp do

  use Application
  require Logger

  def start(_args, _type) do
    Logger.info("Starting app...")
    MainSupervisor.start_link()
  end

  def prep_stop(_state) do
    Logger.notice("The airbags were deployed")
  end

end
