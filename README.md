Elixir Priority Queue Implementation
===================

## From Wikipedia:

A priority queue is an abstract data type which is like
a regular queue or stack data structure, but where additionally each
element has a "priority" associated with it. In a priority queue, an
element with high priority is served before an element with low
priority. If two elements have the same priority, they are served
according to their order in the queue.

While priority queues are often implemented with heaps, they are
conceptually distinct from heaps. A priority queue is an abstract
concept like "a list" or "a map"; just as a list can be implemented with
a linked list or an array, a priority queue can be implemented with a
heap or a variety of other methods.

In computer science, a heap is a specialized tree-based data structure
that satisfies the heap property:

*  If A is a parent node of B, then the key of node A is ordered with
respect to the key of node B, with the same ordering applying
across the heap.

a) Either the keys of parent nodes are always greater than or equal to
those of the children and the highest key is in the root node (this
kind of heap is called max heap)

b) or the keys of parent nodes are less than or equal to those of the
children and the lowest key is in the root node (min heap)

The heap is one maximally efficient implementation of a Priority Queue


## Implementation

This priority queue is implemented using a Pairing Heap.
see:
* http://en.wikipedia.org/wiki/Pairing_heap

A Pairing Heap is a type of heap structure with relatively simple implementation and
excellent practical amortised performance.

Determining the precise asymptotic running time of pairing heaps has proved difficult,
see the Wikipedia page referenced above for a more complete discussion.
In particular practical performance of decrease-key is excellent (and initially
conjectured to be O(1)), but at present it's known to be "no worse" then O(log n).
However, no tight bound is known.

    Operation:
    find-min:     Θ(1)
    delete-min:   Θ(log n)
    insert:       Θ(1)
    decrease-key: Θ(log n) - however, tight bound not known
    merge:        Θ(1)

## Notes

Performance seems to be quite reasonable. If benchmarking, note that other queue implementations can have very variable performance depending on ordering of the items being inserted. The Pairing Heap used here appears to show a much smaller variation in performance with pre-sorted, reverse sorted and random data elements.

Because delete-min times are log(n), one trick which might be useful for huge heaps is to maintain a second heap/list which contains items known to not yet be needed. As the main heap empties some or all of the feeder might be pushed into the main heap. This trick is used to optimise the computation of the "Sieve of Eratosthenes"

We also implement the Collectable and Enumerable interfaces for the Priority Queue.


## Examples

    iex> PriorityQueue.new |> PriorityQueue.empty?
    true

    iex> [4,{8},3,{1, "first"}] |> Enum.into(PriorityQueue.new) |> PriorityQueue.min
    {1, "first"}

    iex> [4,{8},3,{1, "first"}] |> Enum.into(PriorityQueue.new) |> PriorityQueue.pop |> elem(0)
    {1, "first"}

    iex> [4,{8},3,{1, "first"}] |> Enum.into(PriorityQueue.new) |> PriorityQueue.size
    4

    # Heap sort a list
    iex> [4,{8},3,{1, "first"}] |> Enum.into(PriorityQueue.new) |> PriorityQueue.keys
    [1, 3, 4, 8]