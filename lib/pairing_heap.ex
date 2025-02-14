defmodule PairingHeap do
  if Application.compile_env(:priority_queue, :native) do
    @compile :native
    @compile {:hipe, [:o3]}
  end

  @moduledoc """
  Pairing Heap implementation
  see:
      http://en.wikipedia.org/wiki/Pairing_heap

  A Pairing Heap is a type of heap structure with relatively simple implementation and
  excellent practical amortised performance.

  Determining the precise asymptotic running time of pairing heaps has proved difficult,
  see the Wikipedia page referenced above for a more complete discussion.
  In particular practical performance of decrease-key is excellent (and initially
  conjectured to be O(1)), but at present it's known to be "no worse" then O(log n).
  However, no tight bound is known.

  Operation
    find-min:     Θ(1)
    delete-min:   Θ(log n)
    insert:       Θ(1)
    decrease-key: Θ(log n) - however, tight bound not known
    merge:        Θ(1)


  Guts: pairing heaps
  A pairing heap is either nil or a term {key, value, [sub_heaps]}
  where sub_heaps is a list of heaps.

  TODO: Allow the comparison function to be specified
        Implement decrease_key
  """

  @type key :: any
  @type value :: any

  @type t :: {key, value, list} | nil
  @type element :: {key, value}

  @doc """
  return the heap with the min item removed

      iex> PairingHeap.new(1, "first") |> PairingHeap.delete_min |> PairingHeap.empty?
      true

      iex> PairingHeap.new(1, "first") |> PairingHeap.delete_min |> PairingHeap.delete_min |> PairingHeap.empty?
      true
  """
  @spec delete_min(t) :: t
  def delete_min(nil), do: nil
  def delete_min({_key, _v, sub_heaps}) do
    pair(sub_heaps)
  end

  @doc """
  True iff argument is an empty priority queue

      iex> PairingHeap.new |> PairingHeap.empty?
      true

      iex> PairingHeap.new(1, "first") |> PairingHeap.empty?
      false

      iex> PairingHeap.new(1, "first") |> PairingHeap.delete_min |> PairingHeap.empty?
      true
  """
  @spec empty?(t) :: boolean
  def empty?(nil), do: true
  def empty?(_), do: false

  @doc """
  Merge (meld) two heaps
  """
  @spec meld(t, t) :: t
  def meld(nil, heap), do: heap
  def meld(heap, nil), do: heap
  # defp meld(_l = {key_l, value_l, sub_l}, r = {key_r, _value_r, _sub_r}) when key_l < key_r do
  #   {key_l, value_l, [r | sub_l]}
  # end
  # defp meld(l, _r = {key_r, value_r, sub_r}) do
  #   {key_r, value_r, [l | sub_r]}
  # end
  def meld(l = {key_l, value_l, sub_l}, r = {key_r, value_r, sub_r}) do
    cond do
      key_l < key_r -> {key_l, value_l, [r | sub_l]}
      true          -> {key_r, value_r, [l | sub_r]}
    end
  end

  @doc """
  Merge (meld) two heaps
  """
  @spec merge(t, t) :: t
  def merge(h1, h2), do: meld(h1, h2)

  @doc """
  min item in the heap
  """
  @spec min(t, element) :: element
  def min(heap, default \\ {nil, nil})
  def min(nil, default), do: default
  def min({key, value, _}, _default), do: {key, value}

  @doc """
  Create new empty heap.
  Optionally pass in initial key, value
  """
  @spec new :: t
  @spec new(key, value) :: t
  def new(), do: nil
  def new(key, value), do: {key, value, []}

  # Pairing Heaps get their name from the special "pair" operation, which is used to
  # 'Pair up' (recursively meld) a list of pairing heaps.
  @spec pair([t]) :: t
  defp pair([]), do: nil
  defp pair([h]), do: h
  defp pair([h0, h1 | hs]), do: meld(meld(h0, h1), pair(hs))

  @doc """
  Returns the min item, as well as the heap without the min item
  Equivalent to:
    {min(heap), delete_min(heap)}

      iex> PairingHeap.new(1, "first") |> PairingHeap.pop |> elem(0)
      {1, "first"}

  """
  @spec pop(t, element) :: {element, t}
  def pop(heap, default \\ {nil, nil}) do
    {__MODULE__.min(heap, default), delete_min(heap)}
  end

  @doc """
  Add element X to priority queue

      iex> PairingHeap.new |> PairingHeap.put(1, "first") |> PairingHeap.pop |> elem(0)
      {1, "first"}
  """
  @spec put(t, key, value) :: t
  def put(heap, key, value) do
    meld(heap, new(key, value))
  end

end
