defmodule Fizzbuzz.Worker do
  use GenServer

  def calc_fb({n, 0, 0}), do: {n, "FizzBuzz"}
  def calc_fb({n, 0, _}), do: {n, "Fizz"}
  def calc_fb({n, _, 0}), do: {n, "Buzz"}
  def calc_fb({n, _, _}), do: {n, to_string(n)}

  def fizzbuzz(n) do
    cond do
      n < 1 -> {n , "Cannot calculate"}
      true  -> calc_fb({n, rem(n,3), rem(n, 5)})
    end
  end

  ###############
  ### GenServer用の外部APIの実装
  ###############

  def start_link(current_num) do
    IO.puts("start_link/1 call")
    GenServer.start_link(__MODULE__, current_num, name: __MODULE__)
  end

  # 現状のステータス値でのFizzBuzz結果を返す
  def current_fizzbuzz do
    GenServer.call __MODULE__, :current_fizzbuzz
  end

  # ステータス値に+1した結果のFizzBuzz結果を返す
  def next_fizzbuzz do
    GenServer.call __MODULE__, :next_fizzbuzz
  end

  # 現在のステータス値に任意の数を足す
  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  # ステータス値を任意の値に変更
  def change_number(change_num) do
    GenServer.cast __MODULE__, {:change_number, change_num}
  end

  defp schedule_work do
    # In 5 Seconds
    Process.send_after(self(), :work, 5 * 1000)
  end

  ###############
  ### 以降、GenServerの実装
  ###############

  def init(state) do
    IO.puts("init/1  call")
    schedule_work()
    {:ok, state}
  end

  def handle_call(:current_fizzbuzz, _from, current_num) do
    result = current_num |> fizzbuzz()
    { :reply, result, current_num}
  end

  def handle_call(:next_fizzbuzz, _from, current_num) do
    next_num = current_num + 1
    result = next_num |> fizzbuzz()
    { :reply, result, next_num}
  end

  def handle_cast({:increment_number, delta }, current_num) do
    { :noreply, current_num + delta}
  end

  def handle_cast({:change_number, change_num }, _current_num) do
    { :noreply, change_num}
  end

  def handle_info(:work, current_num) do
    {n, v} = current_num |> fizzbuzz()
    IO.puts("schedule_work : #{n} : #{v}")
    # Reschedule once more
    schedule_work()

    {:noreply, current_num + 1}
  end

end
