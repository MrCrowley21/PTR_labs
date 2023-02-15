defmodule AverageCalculator do

### Minimal Task ###
# Create an actor which receives numbers and with each request prints out the
# current average.

# def start(average) do
#   pid = spawn(__MODULE__, :averager, [average])
#   Process.register(pid, :pid)
#   pid
# end

def averager(current_average) do
  receive do
    number -> input_checker(number, current_average)
  end
end

defp input_checker(input, current_average) do
  cond do
    is_integer(input) or is_float(input) ->
      current_average = (current_average + input) / 2
      IO.inspect("Current average is #{current_average}")
      averager(current_average)
    true ->
      IO.puts("Not a valid type of input")
      averager(current_average)
  end
end

end
