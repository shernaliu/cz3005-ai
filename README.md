
# CZ3005 - Artificial Intelligence

## Lab 1 - Problem Solving

In this lab experiment, I used the [AIspace applet](http://www.aispace.org/search/) to draw the trees to answer the following questions:

### Question One

For each of the following, give a graph that is a tree (there is at most one arc into any node), contains at most 15 nodes, and has at most two arcs out of any node.

* Give a graph where depth-first search (DFS) is much more efficient (expands fewer nodes) than breadth-first search (BFS).

* Give a graph where BFS is much better than DFS.

* Give a graph where A* search is more efficient than either DFS or BFS.

* Give a graph where DFS and BFS are both more efficient than A* search.
### Question Two [45 marks]

Progress is made in science by observing a phenomenon of interest, making hypotheses and testing the hypothesis either empirically or by proving theorems.

For this question you are to think about the effect of heuristic accuracy on A* search. That is, you are to experiment with, and think about how close h(n) is to the actual distance from node n to a goal affects the efficiency and accuracy of A*. To get full marks you must at least invent one (plausible, nontrivial) conjecture and either prove it and show some empirical evidence for your answer or show that it is false. Your answers need to be precise (e.g., don’t say “it works better”, but say something like “it always works better”, “it sometimes works better” or “it works better in a majority of cases”).

* What is the effect of reducing h(n) when h(n) is already an underestimate? [15 marks]

* How does A* perform when h(n) is the exact distance from n to a goal? [15 marks]

* What happens if h(n) is not an underestimate? You can give an example to justify your answer. [15 marks]

For more details, please read the PDF report.

## Lab 2 - Reinforcement Learning

In this lab experiement, I implemented a reinforcement learning algorithm called Q-Learning Algorithm in Python to solve the problem of treasure hunting in a cube in a grid-world-based environment.

![CZ3005-Lab2-Reinforcement-Learning](https://res.cloudinary.com/shernaliu/image/upload/v1603092633/github-never-delete/cz3005-ai-lab2.png)

Q-Learning is an off-policy, model-free RL algorithm based on the Bellman Equation. It allows the agent to make use of the environment’s rewards to learn over time to decide on the best action to take in a given state.

`test.py` is the python program implementing the QLAgent and it is also where the main method resides.
To run the program, simply execute `python test.py --max_episode 5000 --max_step 500` to run the QLAgent for 5000 episodes.
You can specify different number of episodes if you wish to do so. The output shows the Q-table, which is a 4D array.

Additionally, a plot of the learning progress which plots episode rewards vs the episode number will be generated. 
This is done using the matplotlib library.

![CZ3005-Lab2-Learning-Progress-Plot](https://res.cloudinary.com/shernaliu/image/upload/v1603092634/github-never-delete/Learning_Progress_Plot.png)

For more details, please read the PDF report.

## Installing CZ3005-AI

```
# clone this project
git clone https://github.com/shernaliu/CZ3005-AI.git
```

To be able to run Lab 2, you need to have Python installed in your system.

