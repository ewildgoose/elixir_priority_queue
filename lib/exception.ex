defmodule PriorityQueue.EmptyError do
  defexception []

  def message(_) do
    "queue empty error"
  end
end