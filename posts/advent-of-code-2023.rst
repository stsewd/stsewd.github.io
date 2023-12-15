.. title: Advent of Code 2023 - solutions and my experience
.. date: 2023-12-26
.. category: problem solving, experience
.. tags: problem solving, experience
.. description: My solutions to Advent of Code 2023 and my experience.

`Advent of Code`_ is a series of programming puzzles that are released every day in December up to Christmas.
Each day, two puzzles are released, the puzzles consist of a story and a set of input data,
and some examples of the expected output.

.. _Advent of Code: https://adventofcode.com/

This is my first year participating in Advent of Code,
I've heard about it before but never really put in the time to participate.
Problem solving using programming isn't something new to me,
I've participated in several `programming competitions`_ in the past,
and `I like solving problems`_ from hackerearth or similar platforms from time to time.
But over the years I've been doing less and less of this, you know, work, life and stuff,
so this was a good opportunity to get back into it!

.. _programming competitions: link to previous blog post
.. _I like solving problems: https://github.com/stsewd/programming-problems-rust

Advent of code is a bit different from the other platforms/contests I've used before.

- You don't submit your solution (code) to the platform, you just submit the answer for a given input.
  This means that there isn't a time or memory limit, and you can use whatever language and libraries you want.
  The limit is your hardware and your time!
  But finding an efficient and general solution is part of the fun.
- There isn't an explicit time limit, you can take as long as you want to solve the problem.
  But it's nice to be able to solve the two problems each day they are released.
- You can solve the problems in any order, you don't have to solve the first problem to unlock the second one and so on.
  If you are stuck in a problem, you can just skip it and come back later.
  But you do need to solve the first part of the problem to unlock the second part.
  # TODO better wording!
- You can't see your global ranking. There is a `leaderboard`_ for the 100 first people,
  and you can create a private leaderboards to compete with your friends, but that's it.

.. _leaderboard: https://adventofcode.com/2023/leaderboard

These differences can be used to your advantage!

- You can take your time to solve the problem using any language you want with your favorite libraries, or any method you want.
  Want to solve it by hand or `using Excel`_? Go ahead! Want to brute force the solution? Go ahead (if your program finishes before Christmas)!
- You need to solve the problem for just the given input, you don't need to worry about edge cases or generalizing your solution,
  you can even check for patterns in the input.

.. _using Excel: https://www.reddit.com/r/adventofcode/comments/189qs63/2023_day_3_a_successful_3rd_day_using_only_excel/

My routine for each day was:

- Solve the first part in the morning (sometimes I read the first part at midnight and go dream about it).
- Solve the second part in the afternoon or evening.
- Go to `Reddit`_ and see how other people solved the problem, and check the memes.
  I think this was the best part of solving the problems with other people around the world,
  you can see how other people solved the problem, and how other people struggled with the same problems you did.
  It's always nice to see other solutions that are more efficient or elegant than yours,
  or some unusual solutions that you didn't think of, and learn from them.

.. _Reddit: https://www.reddit.com/r/adventofcode/

I was very strict with myself, I didn't open Reddit at all until I solved both parts of the problem,
not even to check the memes (they may include spoilers or hints of the solution).
This was a good motivator to solve the problems as soon as possible.

For solving the problems I used Python without any external libraries,
since there is a lot of useful stuff in the standard library,
and Python has several data structures built-in.
I focused on solving the problems in the most efficient way possible (or that I could think of) while trying to maintain the readability of the code.
That second part isn't always easy to maintain, since solutions are bound to how complex the problem is, algorithms used, etc.
You are basically dumping the solution that was in your brain into the code,
and sometimes it's hard to make sense of it later or for other people that aren't
familiar with the steps you took to solve the problem or the algorithms you used.

I was able to solve all the problems in the same day they were released,
except for part 2 of day 10 (more on that later).
I was happy with most of my solutions, and I think I learned a lot from them,
and from reading other people's solutions.
It was great seeing that I wasn't that rusty after not doing this for a while,
and that I was able to solve most of the problems without being completely stuck,
lots of thinking sometimes, but never completely stuck.

That's all from my experience, now let's talk about the problems!
If you haven't solved them yet, I encourage you to try before reading my solutions.


TODO: Some other things I want to mention:

- Focusing on solving the problem in a efficient way made me overthink some solutions,
  and ended with some solutions that were more complex than they needed to be.
  Or ended being slower than a simpler solution.
- Used by notebook (made of paper) for writing notes and testing solutions.

Solutions
---------

Solutions are in Python, the only dependency is ``pytest`` for testing the solutions.
To run the program for a specific input, pass it to stdin (``python <file.py> < <input.txt>``).
Solutions start in the ``solve()`` function.
You can check all solutions in https://github.com/stsewd/advent-of-code-2023.

Day 01
~~~~~~

- Problem: https://adventofcode.com/2023/day/1
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/01.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/01-2.py>`__

This was a nice problem to start with, it was easy to solve and it was a nice warm-up for the next problems.

For the first part, I just iterated from left to right till I found the first number,
and then from right to left till I found the second number.

For the second part, similar I just iterated from left to right till I found the first number, either a digit or a word, and then from right to left,
I used some string operations like ``str.find`` and ``str.rfind``.
I was curious how fast was this compared to using regular expressions,
so I wrote a second solution using regular expressions (``solve2``),
and it ended being slightly faster than the first solution!

Some people had problems with the second part with overlapping words like ``eighthree``,
solving this problem replacing the words to numbers wouldn't work.

Day 02
~~~~~~

- Problem: https://adventofcode.com/2023/day/2
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/02.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/02-2.py>`__

This day was also easy.
The first part, you just needed to check that the number of cubes for a given color wasn't larger than the limit.

For the seconda part, you just needed to keep track of the largest number for each color.

Day 03
~~~~~~

- Problem: https://adventofcode.com/2023/day/3
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/03.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/03-2.py>`__

This day was also easy, a little long to write the solution, but still easy.

For the first part I just kept track of the start and end of each number,
and then used those positions to check if there was a symbol on the surrounding positions.

For the second part I started by collecing all the numbers' positions for each row,
and then iterating over each symbol and checking if it had exactly two numbers on its surrounding positions.

Day 04
~~~~~~

- Problem: https://adventofcode.com/2023/day/4
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/04.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/04-2.py>`__

The first part was easy, I used two sets and then intersected them to get the winner numbers.

The second part, was a classic example of dynamic programming, recursion and memoization to the rescue!
The only *problem* I had here was forgetting to count the initial card itself.

Day 05
~~~~~~

- Problem: https://adventofcode.com/2023/day/5
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/05.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/05-2.py>`__

TODO: put this somewhere?
I started thinking that problems from AoC were easy, or that complexity would increase slowly (I was wrong!).

Days 15
~~~~~~~

- Problem: https://adventofcode.com/2023/day/15
- Solution: `Part 1 <https://github.com/stsewd/advent-of-code-2023/blob/main/15.py>`__, `Part 2 <https://github.com/stsewd/advent-of-code-2023/blob/main/15-2.py>`__

This day was easy for both parts, a nice rest for a Friday.

The first part you just needed some basic math operations, sum and modulo.

For the second part, you needed some linked list operations, deleting, updating, and inserting elements;
but instead of using a linked list, I used a dictionary for quick access to the elements,
this is since Python 3.7+ preserves the insertion order of the elements in a dictionary.
