defmodule Fizzbuzz.Auto do
  use GenServer

  alias Fizzbuzz.Worker 

  ###############
  ### GenServer用の外部APIの実装
  ###############

  def schedule_work do
    # In 5 Seconds
    Process.send_after(self(), :work, 5 * 1000)
  end

  ###############
  ### 以降、GenServerの実装
  ###############

  def init(state) do
    IO.puts("Fizzbuzz.Auto: init/1  call")
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, current_num) do
    {n, v} = current_num |> Worker.fizzbuzz()
    IO.puts("Fizzbuzz.Auto: schedule_work : #{n} : #{v}")
    # Reschedule once more
    schedule_work()

    {:noreply, current_num + 1}
  end
end
