## Project Scope

This project implements and benchmarks an A* algorithm on a 4-connected grid graph with unit cost edges and static obstacles. The goal is to produce a robust software artifact with reproducible performance metrics for this static pathfinding problem.

---

## Getting Started

This project uses a `Makefile` to automate setup and common development tasks.

1.  **Setup the environment:** Run the `setup` target to create the virtual environment and install all dependencies.
    ```bash
    make setup
    ```

2.  **Activate the virtual environment:** To begin working on the project, activate the virtual environment.
    ```bash
    source venv/bin/activate
    ```

---

## Development Workflow

Once your environment is set up and activated, you can use these commands to work on the project.

* **Check the README:** Ensure the project's documentation meets all acceptance criteria. This is useful for verifying Milestone 1.
    
    ```bash
    make check-readme
    ```

---

## Problem Specification

This section defines the grid, coordinate system, and the input/output contract for the pathfinding query.

### Coordinates & Movement

The environment is a **50×50 grid**. Coordinates are **0-indexed** and expressed in `(row, col)` format. Movement is **4-connected** (North, South, East, West), and all edges have a uniform **cost of 1**.

### I/O Schema

The program accepts a single query with the following structure:

|   **Input**   |   **Type**                |   **Description**                     |
|   -           |   -                       |   -                                   |
|   `grid`      |   `50x50 Node Array`      |   The grid containing obstacles.      |
|   `start`     |   `(int, int)`            |   The starting coordinate.            |
|   `goal`      |   `(int, int)`            |   The destination coordinate.         |

|   **Output**      |   **Type**                |   **Description**                                         |
|   -               |   -                       |   -                                                       |
|   `success`       |   `boolean`               |   `true` if a path is found, otherwise `false`.           |
|   `path`          |   `list[(int, int)]`      |   An ordered list of coordinates from start to goal.      |
|   `cost`          |   `int`                   |   The total cost of the path.                             |

#### Output Conditions

* If `success = true`:
  * `path[0]` == `start`.
  * `path[-1]` == `goal`.
  * All consecutive steps in the path must be 4-neighbours.
  * `cost` == `len(path) - 1`.

* If `success = false`.
  * `path` == `null`.
  * `cost` == `0`.

---

## Algorithm Details

### Heuristic Function

The A* algorithm uses the **Manhattan distance** as its heuristic. This is an admissible and consistent heuristic for a 4-connected grid with unit costs. It satisfies the following required properties for optimality:

  1. **Admissibility**: `h(u) ≤ cost(u, v) + h(v)`
  2. **Consistency**: `|h(u) − h(v)| ≤ cost(u, v)`

For any two adjacent nodes `u` and `v` with a unit edge cost of 1, these simplify to:

  1. `h(u) ≤ 1 + h(v)`
  2. `|h(u) − h(v)| ≤ 1`

### Graph Interface

The A* implementation interacts with the grid through a simple, well-defined interface. Neighbor generation is an **O(1)** operation.

|   **Method**                  |   **Description**                                             |
|   -                           |   -                                                           |
|   `neighbors(node)`           |   Returns a list of the 4-connected neighbors of a node.      |
|   `in_bounds(node)`           |   Returns `true` if the node is within the 50x50 grid.        |
|   `passable(node)`            |   Returns `true` if the node is not an obstacle.              |
|   `heuristic(node, goal)`     |   Calculates the Manhattan distance from `node` to `goal`.    |

---

## Milestone 1 — Definition of Done

* The problem statement is clearly defined in the README.
* The "Coordinates & Movement" specifications are present.
* The heuristic is defined, and it's consistency proof includes the required inequalities.
* The "Graph Interface" section lists all required method names.
* The O(1) time complexity for neighbor generation is stated.
* The project includes a binary pass/fail policy for evaluation.