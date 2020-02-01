# genserver_fizzbuzz
FizzBuzzをGenserverで実装したmixのプロジェクト

技術書典8向けの技術同人誌「Elixirへのいざない2」で利用したサンプルプロジェクトの例。

## 利用準備

```
$ git clone https://github.com/rykawamu/genserver_fizzbuzz.git
$ cd genserver_fizzbuzz/fizzbuzz
$ mix deps.get
```

## テストコード実行例

```
$ mix test
start_link/1 call
init/1  call
.....

Finished in 0.05 seconds
1 doctest, 4 tests, 0 failures

Randomized with seed 333352
```

## iex上での実行例

```
$ iex -S mix
Erlang/OTP 22 [erts-10.4.4] [source] [64-bit] [smp:2:2] [ds:2:2:10] [async-threads:1] [hipe]

start_link/1 call
init/1  call
Interactive Elixir (1.10.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Fizzbuzz.Worker.current_fizzbuzz()
{1, "1"}
iex(2)> Fizzbuzz.Worker.next_fizzbuzz()
{2, "2"}
iex(3)> Fizzbuzz.Worker.next_fizzbuzz()
{3, "Fizz"}
iex(4)> Fizzbuzz.Worker.change_number(10)
:ok
iex(5)> Fizzbuzz.Worker.current_fizzbuzz()
{10, "Buzz"}
iex(6)> Fizzbuzz.Worker.next_fizzbuzz()
{11, "11"}
iex(7)> Fizzbuzz.Worker.next_fizzbuzz()
{12, "Fizz"}
iex(8)> Fizzbuzz.Worker.increment_number(3)
:ok
iex(9)> Fizzbuzz.Worker.current_fizzbuzz()
{15, "FizzBuzz"}
```
