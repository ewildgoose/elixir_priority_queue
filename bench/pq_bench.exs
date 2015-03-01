defmodule Bench do
  use Benchfella

@sorted_list Enum.to_list(1..100_000)
@unsorted_list Enum.to_list(100_000..1)
@random_list Stream.repeatedly(fn -> :random.uniform(100000) end) |> Enum.take(100_000)

  bench "sort sorted list" do
    @sorted_list
    |> Enum.into(PriorityQueue.new)
    |> PriorityQueue.keys
  end

  bench "sort unsorted list" do
    @unsorted_list
    |> Enum.into(PriorityQueue.new)
    |> PriorityQueue.keys
  end

  bench "sort random list" do
    @random_list
    |> Enum.into(PriorityQueue.new)
    |> PriorityQueue.keys
  end

end