.. title: Problem Solving Basics - with Python tips
.. date: 2021-03-27
.. category: problem solving, python
.. description: Basic concepts and tips for solving programming problems.

What exactly am I talking about when I said "problem solving"?
I'm talking about problems you can solve with the help of a programming language,
but most important, I'm talking about solving them in an efficient way (time and space).

.. warning::

   The content on this post is based on my experience solving problems
   `as hobby <https://www.hackerrank.com/stsewd>`__,
   `at work <link://filename/pages/about.rst>`__,
   `and in competitions <link://filename/posts/devsucodejam-2019.rst>`__.
   After reading this article you won't be able to win a programming contest,
   but hopefully you will feel more confident at it.

.. contents::
   :depth: 3

How efficient is my program?
----------------------------

When we talk about a program's efficiency,
we talk about how long the program takes to complete a task,
and how much memory it uses while doing so.

We could messure this by using the ``time`` [#time]_ and ``ps`` [#ps]_ commands,
but that would give us different results on different computers or even on the same computer [#different-results-same-pc]_.
So instead of saying *It works on my computer!* you would be saying *It's efficient on my computer!*,
we need a better way to measure this... Big O notation to the rescue!

Big O notation
--------------

`Big O notation <https://en.wikipedia.org/wiki/Big_O_notation>`__
is a mathematical notation that allows us to classify algorithms by their growth rate
(run time and space, we focus on the time most of the time) in base on its input value/size given the worst case of the algorithm.

This notation is expressed as the function ``O(x)``,
where ``x`` is an expression that represents the number of operations based on the input.
Wait... number of operations? Weren't we talking about measuring the time?
Yeah, but since run time can vary between computers, the function depends on the number of operations instead,
so the final result (time) can be calculated as ``t * x``, where ``t`` is the number of milliseconds that each operation takes on a given computer.

That makes sense! Wait again...
what exactly do you mean with *operation* and how can each operation take the same amount of time!?
For operation I mean the most simple and basic operations you can do with a programming language.
Like adding two numbers (``a + b``), making a logical comparison (``if a == b: ...``),
assign a variable, loop over a list, and so on.
But you are right, each of these operations don't take exactly the same amount of time
(probably for a computer calculating ``1 * 0`` is faster than ``2 * 9999``),
but remember that the big O notation is about the worst case, and isn't about an exact value but a growth rate,
so we don't care about that level of detail.

Common orders of functions
--------------------------

Some common orders of functions and their names are:

.. figure:: /images/problem-solving/big-o-notation.png
   :target: /images/problem-solving/big-o-notation.png
   :align: center

   Common functions of big O notation (time vs input)

Constant
````````

``O(1)`` constant, if your algorithm always run the same number of operations for any given input.
This is the best order you can get.
For example when checking if a number is even or odd.

.. code:: python

   """
   Even or odd?

   Receives a number as input. For example::

   4
   """

   number = int(input())
   if number % 2 == 0:
      print("Even!")
   else:
      print("Odd!")

Here it doesn't matter how big is the number,
we always perform one operation (``number % 2``).

Linear
``````

``O(n)`` linear, if your algorithm growths at the same rate of its input.
For example a linear search algorithm.

.. code:: python

   """
   Linear search.

   Receives a line of space separated numbers and the number to search for.
   For example::

     4 5 2 1 3
     2
   """

   numbers = map(int, input().split())
   to_find = int(input())

   index = -1
   for i, number in enumerate(numbers):
       if number == to_find:
           index = i
           break;

   if index >= 0:
      print(f"Number found at the ${i} position")
   else:
      print(f"Number not found")

Here the number of operations depends of the number of elements and the element to find,
and the worst case happens when the number to find isn't present,
so in that case we end up looping through all ``n`` elements.

Quadratic
`````````

``O(n^2)`` quadratic, if your algorithm growths by combining all the elements of the input with themselves.
For example if we have three elements: ``a, b, c``,
the combination would result in nine elements (``3^2``):
``(a, a), (a, b), (a, c), (b, a), (b, b), (b, c), (c, a), (c, b), (c, c)``.
For example the bubble sort algorithm.

.. code:: python

   """
   Bubble sort.

   Receives a line of numbers separated by space as input.
   For example::

     5 3 4 1 2
   """

   numbers = list(map(int, input().split()))

   for i in range(len(numbers)):
       for j in range(len(numbers)):
           a, b = numbers[i], numbers[j]
           if a < b:
               numbers[i] = b
               numbers[j] = a

   print(numbers)

Here we iterate over all the combinations of the array by the array itself
in order compare each elements over and over till the array is sorted.

Polynomial
``````````

``O(n^3)``, ``O(n^x)`` cubic and polynomial, same as quadratic, but we do ``x`` number of combinations.
A common misunderstanding here is that the number of loops dictates the order of the polynomial,
this isn't always true, as you can have algorithms with a different growth rate with ``n`` loops.
Always check the boundaries of the loops to calculate the order of the algorithm.
You can use this code to experiment with polynomial growths.

.. code:: python

   """
   Combinations generator.

   Receives a line of space separated elements and the number of combinations.
   For example::

     1 2 3
     2
   """

   from itertools import product

   numbers = input().split()
   n = int(input())
   arrays = [numbers] * n
   count = 0
   for pair in product(*arrays):
       count += 1
       print(pair)
   print(f"Number of combinations generated: {count}")

Factorial
`````````

``O(n!)`` factorial, this is the worst order you'll see around.
Here your algorithm growths with the permutations of all elements of the input.
For example if we have the three elements: ``a, b, c``, the permutation would result in six elements (``3! = 1 * 2 * 3``):
``(a, b, c), (a, c, b), (b, a, c), (b, c, a), (c, a, b), (c, b, a)``.
You can use this code to experiment with factorial growths.

.. code:: python

   """
   Permutations generator.

   Receives a line of space separated elements.
   For example::

     1 2 3
   """

   from itertools import permutations

   numbers = input().split()
   count = 0
   for pair in permutations(numbers, len(numbers)):
      count += 1
      print(pair)
   print(f"Number of permutations generated: {count}")

Algorithms
----------

Data structures
---------------

Number theory
-------------

Bit manipulation
----------------

String operations
-----------------

In some languages strings are inmutable.

Optimization
------------

Language level optimizations
````````````````````````````

Some times you don't have control over the implementation of the algorithm (like when using a library)
or the implementation of the low level code of the programming language you are using.
Read the documentation, take a look at their implementation.

Let's see some examples in Python.

.. code:: python

   """Benchmark of sum vs a for loop."""

   from timeit import timeit

   def one(array):
      result = 0
      for i in array:
         result += i
      return result

   def two(array):
      return sum(array)

   array = [i for i in range(99999)]
   first = timeit(lambda: one(array), number=999)
   second = timeit(lambda: two(array), number=999)
   print("Results")
   print(f"Using a for loop: {first}")
   print(f"Using builtin sum: {second}")

Result from my local testing::

   Results
   Using a for loop: 3.1789832370013755
   Using builtin sum: 0.602840360999835

As you can see, using the builtin ``sum`` is faster than using a for loop.
This may be due tha sum is implemented at the C level.

.. code:: python

   """Benchmark of list comprehensions vs a for loop."""

   from timeit import timeit

   def one(array):
       solution = []
       for i in array:
           solution.append(i * i)
       return solution

   def two(array):
       return [
           i * i
           for i in array
       ]

   array = [i for i in range(99999)]
   first = timeit(lambda: one(array), number=999)
   second = timeit(lambda: two(array), number=999)
   print("Results")
   print(f"Using a for loop: {first}")
   print(f"Using list comprehension: {second}")

Result from my local testing::

   Results
   Using a for loop: 6.891558821000217
   Using list comprehension: 4.766570706999119

As you can see using list comprehensions is faster than using a loop.
This may be due that using a loop requires several calls to ``append``,
and maybe re-allocating memory every time the array outgrowths from the current limit.

Other areas
-----------

- Physics
- Geometry

Solving the problem
-------------------

Programming language
--------------------

Tips
----

Over engineering
----------------

First, solve the problem. Then, write the code.

----

.. [#time] ``man time``
.. [#ps] ``man ps``
.. [#different-results-same-pc] Another program could be taking the resources of your computer,
   making the other program run slow.
