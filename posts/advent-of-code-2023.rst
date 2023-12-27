.. title: Advent of Code 2023 - solutions and my experience
.. date: 2023-12-26
.. category: problem solving, experience
.. tags: problem solving, experience
.. description: My solutions to Advent of Code 2023 and my experience.

`Advent of Code`_ is a series of programming puzzles that are released every day in December up to Christmas.
Each day, two puzzles are released, the puzzles consist of a story and a set of input data,
and some examples of the expected output.

.. _Advent of Code: https://adventofcode.com/

.. contents:: Contents
   :depth: 1
   :local:
   :backlinks: none

The start of a journey
----------------------

This is my first time participating in Advent of Code,
I've heard about it before but never really put in the time to participate.
Problem solving using programming isn't something new to me,
I've participated in several `programming competitions`_ in the past,
and `I like solving problems`_ from `HackerEarth`_ or similar platforms from time to time.
But over the years I've been doing less and less of this,
so this was a good opportunity to get back to it!

.. _programming competitions: link://filename/posts/devsucodejam-2019.rst
.. _I like solving problems: https://github.com/stsewd/programming-problems-rust
.. _HackerEarth: https://www.hackerearth.com/@stsewd

Embracing differences as your new friends
-----------------------------------------

Advent of code is a bit different from other platforms/contests I've used before.

- You don't need to submit your code; you only submit the answer for a given input.
  This means no time or memory constraints, the limit is your hardware and your time!
  But finding an efficient and general solution is part of the fun.
- There isn't an explicit time limit, you can take as long as you want to solve the problems.
  But it's nice to be able to solve the two parts of the problem on the day they are released.
- You don't need to solve the problems from the previous days to unlock the next day,
  but you do need to solve the first part of a problem to unlock its second part.
- The `global ranking`_ is only for the first 100 people that solved each problem.

.. _global ranking: https://adventofcode.com/2023/leaderboard

These differences can be used to your advantage!

- Use any language you want with your favorite libraries, or any method you want.
  Want to solve it by hand or `using Excel`_? Go ahead! Want to brute force the solution? Go ahead (if your program finishes before Christmas)!
- Focus on solving the problem for just the given input, you don't need to worry about edge cases or generalizing your solution,
  you can even search for patterns in the input.

.. _using Excel: https://www.reddit.com/r/adventofcode/comments/189qs63/2023_day_3_a_successful_3rd_day_using_only_excel/

My daily routine
----------------

My routine for each day was:

#. Solve the first part in the morning (sometimes I read it at midnight and go dream about it).
#. Solve the second part in the afternoon or evening.
#. Go to `Reddit`_ and see how other people solved the problem and check the memes.

The best part of solving the problems with people around the world
is that you can see how others solved the problems, and how they struggled with the same problems you did.
It's always nice to read solutions that are more efficient or elegant than yours,
or some unusual solutions that you didn't think of, and learn from them.

.. _Reddit: https://www.reddit.com/r/adventofcode/

I refrained from opening Reddit until I solved both parts of the problem,
not even checked the memes (they may include spoilers or hints of the solution).
This was a good motivator to solve the problems as soon as possible.

The right tools for the job
---------------------------

The tools I used:

Python
   I used Python without external libraries,
   since there is a lot of useful stuff in the standard library,
   and it has several data structures built-in.
Pen and paper
   Essential for writing notes, manually testing solutions,
   exploring formulas, looking for patterns, etc.
Neovim
   My editor of choice; I use Neovim, BTW.

I focused on solving the problems in the most efficient way I could think of, while trying to maintain readability.
Maintaining readability isn't always easy to maintain, since solutions are bound to how complex the problem is, algorithms used, etc.
You are basically dumping the solution that was in your brain into the code,
and sometimes it's hard to make sense of it later or for other people that aren't
familiar with the steps you took to solve the problem or the algorithms you used.

Focusing on solving the problem efficiently led me to overthink some solutions sometimes,
ending with solutions that were more complex than they needed to be,
or slower than a simpler solution.

Results and reflections
-----------------------

I solved 39 out of the 50 problems.
Up to the 19th day, I was really focused and solved most of the problems on the same day they were released.
The last five days I dedicated less time to solve the problems,
to enjoy the holidays and do other things away from the computer.
The problems got more complex too, I gave up on some,
the last three I didn't even read them.

.. figure:: /images/advent-of-code-2023/personal-leaderboard.png
   :target: /images/advent-of-code-2023/personal-leaderboard.png
   :alt: My personal leaderboard

   My personal leaderboard

I'm happy with most of my solutions, and I learned a lot from reading others' solutions.
It was great seeing that I wasn't that rusty,
and that I was able to solve most problems without being completely stuck,
lots of thinking, but never completely stuck.

Participating in Advent of Code was a great experience, but exhausting too,
50 problems in 25 days is a lot, specially during the holidays.

On the positive side, it made me think about solving problems more often,
and read more about algorithms and data structures, especially graph theory.
I might revisit the unsolved problems in the future.

That's all from my experience, now let's talk about the problems!
If you haven't solved them yet, I encourage you to try before reading my solutions.

.. note::

   Are you curious about how to prepare for these type of problems,
   the algorithms you need to know, etc?
   I may revive an old post I started writing about this topic some years ago if there is enough interest.
   Comment below if you are interested!

Solutions
---------

  "Talk is cheap. Show me the code."

  -- Linus Torvalds

The solutions are in Python, the only dependency is ``pytest`` for testing the solutions.
To run the program for a specific input file, pass it as the first argument (``python <file.py> <input.txt>``).
The solution starts in the ``solve()`` function.
You can check all solutions in https://github.com/stsewd/advent-of-code-2023.

At continuation, I'll talk about each day and my solution for each part.
Note that this isn't a step-by-step guide to solving the problems,
but more of a general overview of my solution and my experience.
But I'll try to answer any questions you may have about my solutions in the comments.

If you haven't solved the problems yet,
I encourage you to try before reading my solutions.

Day 01
~~~~~~

- Problem: https://adventofcode.com/2023/day/1
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/01.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/01-2.py>`__

This was a nice problem to start with, it was easy to solve, and it was a nice warm-up for the next problems.

For the first part, I iterated from left to right till I found the first number,
and then from right to left till I found the second number.

For the second part, I iterated from left to right till I found the first number, either a digit or a word, and then from right to left.
I used string operations like ``str.find`` and ``str.rfind``.
I was curious how fast was this compared to using regular expressions,
so I wrote a second solution using regular expressions (``solve2``),
it turned out to be slightly faster than my initial solution!

Some people had problems with the second part with overlapping words like ``eighthree``,
solving this problem replacing the words to numbers wouldn't work.

Day 02
~~~~~~

- Problem: https://adventofcode.com/2023/day/2
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/02.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/02-2.py>`__

Another easy day.
For the first part, you needed to check that the number of cubes for a given color wasn't larger than the limit.

For the second part, you needed to keep track of the largest number for each color.

Day 03
~~~~~~

- Problem: https://adventofcode.com/2023/day/3
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/03.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/03-2.py>`__

This day was also easy, a little long to write the solution, but still easy.

For the first part, I tracked the start and end of each number,
and then used those positions to check if there was a symbol surrounding them.

For the second part, I collected all the numbers' positions for each row,
and then iterated over each symbol and checked if it had exactly two numbers surrounding it.

Day 04
~~~~~~

- Problem: https://adventofcode.com/2023/day/4
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/04.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/04-2.py>`__

The first part was easy, I used two sets and then intersected them to get the winner numbers.

The second part, was a classic example of `dynamic programming`_, recursion and memoization to the rescue!
The only *problem* I had here was forgetting to count the initial cards.

.. _dynamic programming: https://en.wikipedia.org/wiki/Dynamic_programming

Day 05
~~~~~~

- Problem: https://adventofcode.com/2023/day/5
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/05.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/05-2.py>`__

For the first part, I created a list with the ranges,
and for each seed I'd check if its value was in any of those ranges,
and convert it to the new number.
The answer is the minimum value of the final value of the seeds.

For part two, I created a list with the ranges sorted for each mapping so it would be easier to match them later,
then I applied a similar logic as the first part, but instead of keeping track of a single value, I kept track of ranges.
This is, we first start with a range, then we transform that range into another range, and so on.
The answer is the minimum value of all the final ranges.

Day 06
~~~~~~

- Problem: https://adventofcode.com/2023/day/6
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/06.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/06-2.py>`__

For this problem, we need to find the times that beat the current record.
The *peak time* (time pressing the button that allows us to travel as far a possible)
is the half of the allowed time, after the peak time the distance traveled decreases.

With that in mind, we can count the distance traveled for each time from one to the peak time that beats the current record.
I first solved both parts by iterating over all those times till I found the best time,
but then I found that finding the best time can be done using a quadratic equation,
thus solving the problem in constant time,
but looping over was fast enough for the given input too.

Day 07
~~~~~~

- Problem: https://adventofcode.com/2023/day/7
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/07.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/07-2.py>`__

This problem requires a custom comparison between the two set of hands,
Python has a ``functools.cmp_to_key`` function that can be used to compare two objects,
and can be used as the ``key`` function for the sort/sorted functions.
Avoiding the need to create custom objects with a ``__lt__`` method.

For the first part the comparison function was easy, just get the type for each hand and compare them,
to get the type of hand, we can use a ``Counter`` to count the number of times each card appears in the hand.

For the second part, I first got the type of the hand without the jokers,
and then *promoted* the hand to the best possible hand with the jokers available.

Day 08
~~~~~~

- Problem: https://adventofcode.com/2023/day/8
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/08.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/08-2.py>`__

For the first part I built a map of each node to its neighbors,
and then started from the node ``AAA`` following the directions until I found the node ``ZZZ``.

For the second part, I built a list with all the start nodes,
then I was thinking of the best way to follow the directions concurrently for each node and check if all of them reached their end node,
I tested each node separately and found that after reaching their end node, each node will go back to their start node.
With that information, it was just a matter of remembering the mathematical function to calculate when all nodes will be at their end node at the same time,
that function is the least common multiple (`LCM`_) of the number of steps of each node's cycle.

.. _LCM: https://en.wikipedia.org/wiki/Least_common_multiple

Day 09
~~~~~~

- Problem: https://adventofcode.com/2023/day/9
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/09.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/09-2.py>`__

For this problem, I overthought the solution finding a formula, thinking it would pay off in the second part.
After writing some examples on paper, I found that the solutions followed the pattern of a `Pascal's triangle`_
(at the time I didn't remember the name of the triangle, so I had to Google for "math triangle 1").

For the second part, the problem just asked for the value of the start,
so it was a matter of doing the same operation, but with the list reversed.

Probably wasted a lot of time, but I'm happy that I was able to solve the problem in linear time,
and that I was able to remember the name of the Pascal's triangle.

.. _Pascal's triangle: https://en.wikipedia.org/wiki/Pascal's_triangle

Day 10
~~~~~~

- Problem: https://adventofcode.com/2023/day/10
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/10.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/10-2.py>`__

This was problem was hard for me, I was stuck in the second part for 4 days.
But more than stuck, I think I was blocked, like I knew the solution was there, but was having a hard time implementing it.

For the first part I started by trying to follow each valid path recursively,
but then I realized that there was just one valid path, so I just followed the first valid path I found.

For the second part, I tried to think of different ways to fill the polygon,
but none of them seemed to work for all the cases.
The solution that worked for most cases was to try to fill the polygon from left to right pairing the vertical edges,
but I was having a hard time figuring out the rules to pair the edges.
After failing for several days, I decided to search for existing algorithms for filling a polygon.
I found the `Scanline algorithm`_, and after `reading`_ `about it`_ and understanding it, I was able to implement it in Python,
I'm happy that the solution I was trying to implement was similar to how this algorithm works,
but also I should have searched for this algorithm earlier. You live, you learn.

After reading others' solutions, I found that there was an even simpler solution
using the `Pick's theorem`_ to get the number of points inside a polygon
(this came handy for Day 18!).

.. _Scanline algorithm: https://en.wikipedia.org/wiki/Scanline_rendering
.. _reading: https://www.geeksforgeeks.org/scan-line-polygon-filling-using-opengl-c/
.. _about it: https://www.cs.drexel.edu/~deb39/Classes/CS430/Lectures/L-05_Polygons.pdf
.. _Pick's theorem: https://en.wikipedia.org/wiki/Pick's_theorem

Day 11
~~~~~~

- Problem: https://adventofcode.com/2023/day/11
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/11.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/11-2.py>`__

I initially solved the first part expanding the grid,
but after reading the second part I realized that I could just keep track of the rows/columns that needed to be expanded,
and use that to calculate the final answer.

Day 12
~~~~~~

- Problem: https://adventofcode.com/2023/day/12
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/12.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/12-2.py>`__

I solved this problem by recursively testing what would be the result if each of the ``?`` would be replaced by a ``#`` or ``.``,
and instead of copying the rest of the string and group, I just passed their indexes to the function.
This solution was fast for the first part, for the second I had to implement a cache to avoid recalculating the same group twice,
the cache was per each row, it took around 4 seconds to complete, I saw other people applying the cache to the whole matrix,
I may try that later and see if it's faster.

Day 13
~~~~~~

- Problem: https://adventofcode.com/2023/day/13
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/13.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/13-2.py>`__

Instead of doing the operations over the matrix,
I used a binary number to represent the state of each row and column,
then finding the line of reflection was just a matter of comparing numbers.

For the second part, I brute forced the solution,
since I was using binary numbers, getting the possible combinations was
a matter of flipping the bits using a ``XOR`` operation.

Day 14
~~~~~~

- Problem: https://adventofcode.com/2023/day/14
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/14.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/14-2.py>`__

The first part was easy, moving all rocks till we reach a *blocker* (another rock or the end of the grid).

For the second part, I *cheated* a little by using the rules to my advantage,
this is, solving the problem for the given input only.
Analyzing the first 200 iterations, I found that after some iterations a pattern repeats,
so I manually searched for the start of the pattern, and the number of iterations it takes to repeat.
Then, I did some math to get the minimum number of iterations to reach the final answer.

Day 15
~~~~~~

- Problem: https://adventofcode.com/2023/day/15
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/15.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/15-2.py>`__

This day was easy for both parts, a nice rest for a Friday.

The first part you just needed some basic math operations, sum and modulo.

For the second part, you needed some linked list operations,
but instead of using a linked list, I used a dictionary for quick access to the elements,
this is since Python 3.7+ preserves the insertion order of the elements in a dictionary.

Day 16
~~~~~~

- Problem: https://adventofcode.com/2023/day/16
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/16.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/16-2.py>`__

For this problem, I traversed the matrix following the directions from the mirrors, while keeping track of the points and their direction that were visited.
The result is the number of unique points visited without taking into consideration the direction.

For the second part, I was thinking of using dynamic programming to solve it efficiently,
but wasn't sure how to do it while keeping track of previous visited points.
So, I just iterated over all start positions and directions and kept track of the maximum number of points visited on each iteration,
it completed under two seconds, so I didn't bother optimizing it further.

Day 17
~~~~~~

- Problem: https://adventofcode.com/2023/day/17
- Solution:

This one was another hard one for me. I wasn't able to solve it.

After failing to solve it using recursion,
I realized that this was a path finding problem,
probably a variation of Dijkstra's algorithm.
My knowledge about graph theory and friends is a little rusty,
so I started reading and understanding Dijkstra's algorithm,
but I wasn't able to adapt it to this problem.

Day 18
~~~~~~

- Problem: https://adventofcode.com/2023/day/18
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/18.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/18-2.py>`__

An easy day, great start for a Monday, a relief after day 17.
Well, it's easy if you already solved Day 10, since it's the same principle.

On day 10 I learned about `Pick's theorem`_ to get the number of points inside a polygon,
and I also about the `shoelace formula`_ to get the area of a polygon.
Using both formulas, I was able to solve the problem in linear time.

.. _Pick's theorem: https://en.wikipedia.org/wiki/Pick's_theorem
.. _shoelace formula: https://en.wikipedia.org/wiki/Shoelace_formula

Day 19
~~~~~~

- Problem: https://adventofcode.com/2023/day/19
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/19.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/19-2.py>`__

This problem was similar to Day 05.
For the first part, I built a map with the workflows,
and followed them until reaching the workflow ``A`` or ``R``.

For the second part, we had to find a range of values that would satisfy the given conditions,
but here the ranges had branches, so I recursively collected all the possible ranges that reached to the ``A`` workflow,
the final solution was a matter of multiplying those ranges.

Day 20
~~~~~~

- Problem: https://adventofcode.com/2023/day/20
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/20.py>`__

Part one was kind of easy,
the hardest part was understanding the operations for each type of module,
after that I looped over the operations till we didn't have any more operations to process.

I wasn't able to solve part two,
I tried for like two hours, and then gave up.
Didn't even bother on trying to solve it later.

Probably was on this day when I decided to dedicate less time to solve the problems, and enjoy more the holidays.

Day 21
~~~~~~

- Problem: https://adventofcode.com/2023/day/21
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/21.py>`__

For part one I recursively traversed the matrix,
and realized that if the remaining steps were even,
returning to the previous position was guaranteed,
avoiding having to check what would happen if we went back.
That with a simple cache was fast enough to solve the first part.

The second part was more difficult, and wasn't able to solve it,
I tried for like one hour, and then gave up.

Day 22
~~~~~~

- Problem: https://adventofcode.com/2023/day/22
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/22.py>`__

I solved this one on the next day, I was busy with the holidays and social life.

I haven't played with 3D matrices in a while,
so it took me a while to think of a solution that was easy to code.

Drawing inspiration from Dijkstra's algorithm,
I sorted all bricks by their z coordinate,
and for each brick I checked all bricks below it, searching for one that would *stop* it by checking if their x and y coordinates intersected.
After that, I built a map with all the bricks and the bricks above it that intersected with it.
To get the final answer, I used a set difference, if the set was empty, the brick could be safely removed.
It was a long solution, but it was still fast.

For the second part, I used the same logic from the first part,
but instead of using sets, I built a graph with the bricks and their intersections,
and recursively exploring the bricks that will fall,
it worked for the example, and it made sense on paper,
but the solution was wrong for the given input,
so I gave up after that.

Day 23-25
~~~~~~~~~

As previously mentioned, I didn't even read the problems for these days.
I went to enjoy the holidays, and do other things away from the computer.
I may go back and try to solve these problems some day.

Hope you enjoyed reading about my experience and solutions!
See you next year!
