defmodule StringSupervisor do

### Main Task ###
# Create a supervised processing line to clean messy strings. The first worker in
# the line would split the string by any white spaces (similar to Python’s str.split method).
# The second actor will lowercase all words and swap all m’s and n’s (you nomster!). The third
# actor will join back the sentence with one space between words (similar to Python’s str.join
# method). Each worker will receive as input the previous actor’s output, the last actor printing
# the result on screen. If any of the workers die because it encounters an error, the whole
# processing line needs to be restarted. Logging is welcome.

use Supervisor
require Logger

def init(_args) do
  workers = [
    Supervisor.child_spec(Splitter, id: :splitter),
    Supervisor.child_spec(Nomster, id: :nomster),
    Supervisor.child_spec(Joiner, id: :joiner)]
  # IO.inspect(workers)
  # Logger.info("Workers were created")
  Supervisor.init(workers, strategy: :one_for_all)
end

def start_link() do
  Logger.info("Workers were started")
  Supervisor.start_link(__MODULE__, [], name: __MODULE__)
end

def split_string(input_string, is_alive) do
  if is_alive == 1 do
    GenServer.call(:splitter, {:split, input_string})
  else
    GenServer.call(:splitter, {:kill})
  end
end

def replace_mn(input_list, is_alive) do
  if is_alive == 1 do
    GenServer.call(:nomster, {:replace_mn, input_list})
  else
    GenServer.call(:nomster, {:kill})
  end
end

def join_list(input_list, is_alive) do
  if is_alive == 1 do
    GenServer.call(:joiner, {:join, input_list})
  else
    GenServer.call(:joiner, {:kill})
  end
end

def clean_string(input_string) do
  splitted_string = split_string(input_string, :rand.uniform(2))
  replaced_list = replace_mn(splitted_string, :rand.uniform(2))
  joined_list = join_list(replaced_list, :rand.uniform(2))
  IO.puts("Processed string: #{joined_list}")
end

end
