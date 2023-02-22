defmodule Nomster do

  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: :nomster)
  end

  def init(_args) do
    Logger.info("Nomster is initialized")
    {:ok, []}
  end

  def handle_call({:replace_mn, input_list}, _from, state) do
    Logger.info("Splitted list received")
    replaced_list = replace(input_list)
      # input_list
      # |> Enum.map(fn(word) ->
      #     String.downcase(word)
      #   end)
      #   |> Enum.map(fn(word) ->
      #     String.to_charlist(word)
      #   end)
      # |> Enum.map(fn(word) ->
      #     Enum.map(word, &case &1 do
      #       ?n -> ?m
      #       ?m -> ?n
      #       other -> other
      #     end)
      #   end)
    Logger.info("Current string form: #{replaced_list}")
    {:reply, replaced_list, state}
  end

  def handle_call({:kill}, _from, _state) do
    Logger.info("I am killed")
    Process.exit(self(), :died)
  end

  def replace(input_list) do
    _replaced_list =
      input_list
      |> Enum.map(fn(word) ->
          String.downcase(word)
        end)
        |> Enum.map(fn(word) ->
          String.to_charlist(word)
        end)
      |> Enum.map(fn(word) ->
          Enum.map(word, &case &1 do
            ?n -> ?m
            ?m -> ?n
            other -> other
          end)
        end)
  end

end
