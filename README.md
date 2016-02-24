# Maze generator

<a href="https://codeclimate.com/github/ctakahashi/mazes"><img src="https://codeclimate.com/github/ctakahashi/mazes/badges/gpa.svg" /></a>

This project was done with object oriented design in mind. There is still much for me to learn,
but I feel that I am really getting to understand the way object oriented design should work.

As of right now there are four classes that handle different jobs. A Maze class which is like the overhead class that creates instances
of other classes to be used for a maze. A Cell class that represents a single cell or block in a maze. The MazeMaker is the class that
creates the maze using Cell instances. The MazeSolver is a basic class that simply implements an algorithm to find a path from one point
in the maze to another.

There is also a simple client file that allows for user interaction which will can generate a maze randomly for some m x n length and width,
respectively. It will also ask the user if he/she would like to see the shortest route from point A to B. The input for the coordinates must
be entered as follows however: startX, startY, endX, endY. There can be any number of commas and any number of spaces.

MazeMaker
There are two algorithms used to design a maze.
- Recursive backtracking: I used a stack to keep track of Cells that have not been fully explored, meaning there is a pathway from that
cell that hasn't been viewed yet. More information can be Googled
- Random: This is a very simple algorithm that basically selects a random number of walls for each cell and creates those walls in
a random direction by altering a few simple booleans.

MazeSolver
- Here I used a simple implementation of breadth first search to find the shortest path from point A to point B in the maze that is generated.
- The trace basically implemented the solve method and display method to show the path.
