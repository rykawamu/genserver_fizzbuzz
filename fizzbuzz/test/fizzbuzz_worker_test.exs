defmodule FizzbuzzWorkerTest do
  use ExUnit.Case
  doctest Fizzbuzz.Worker

  alias Fizzbuzz.Worker

  test "test fizzbuzz" do
    assert Worker.fizzbuzz(1)  == {1, "1"}
    assert Worker.fizzbuzz(6)  == {6, "Fizz"}
    assert Worker.fizzbuzz(10) == {10, "Buzz"}
    assert Worker.fizzbuzz(15) == {15, "FizzBuzz"}
    assert Worker.fizzbuzz(0)  == {0, "Cannot calculate"}
  end

  test "calculate the fizzbuzz" do
    assert Worker.calc_fb({30, 0, 0}) == {30, "FizzBuzz"}
    assert Worker.calc_fb({30, 0, 1}) == {30, "Fizz"}
    assert Worker.calc_fb({30, 1, 0}) == {30, "Buzz"}
    assert Worker.calc_fb({30, 1, 1}) == {30, "30"}
  end

  test "genserver method check" do
    Worker.change_number(10)
    val = Worker.current_fizzbuzz()
    assert val == {10, "Buzz"}

    val = Worker.next_fizzbuzz()
    assert val == {11, "11"}

    val = Worker.next_fizzbuzz()
    assert val == {12, "Fizz"}

    Worker.increment_number(3)
    val = Worker.current_fizzbuzz()
    assert val == {15, "FizzBuzz"}
  end

end
