<div align="center">
  <h1>Battleship</h1>
</div>

## Project Overview & Learning Goals
Battleship is a classic board game where players place one or more ships on a grid board, and then take turns trying to “sink” the other player’s ships by guessing their coordinates. The game ends when one player’s ships are all hit and “sunk”.

This project uses Ruby to build a command line implementation of the classic game Battleship, in order to demonstrate Test-Driven Development (TDD), algorithmic thinking, and Object Oriented Programming.

## Built With
- Ruby 2.7.2

## Setup
1. Clone the repository
2. cd into the root directory
3. Run the game `ruby battleship_runner.rb`
4. You may run the RSpec test suite locally with `bundle exec rspec`

## Features and Screenshots
* Game board is presented in a grid, with the following:
 * `.` represents an empty space
 * `S` represents a ship on your board
 * `H` represents a hit
 * `M` represents a shot that missed
 * `X` represents a sunken ship
<img width="445" alt="Screenshot 2023-07-15 at 3 12 35 PM" src="https://user-images.githubusercontent.com/110333328/253768597-14f47d98-b86e-4dd4-9543-19d4a0e7c2dc.png">


* Option to customize board size from 4 to 10 rows/columns
<img width="712" alt="Screenshot 2023-07-15 at 2 50 18 PM" src="https://user-images.githubusercontent.com/110333328/253768094-f7d83264-dd00-47f8-85e4-19c6581b4464.png">


* Ability to detect when invalid coordinates are entered for ship placement or shot location
<img width="716" alt="Screenshot 2023-07-15 at 2 57 54 PM" src="https://user-images.githubusercontent.com/110333328/253768133-a66a494d-dd39-411f-a0b3-9320a3e059f3.png"> -<img width="418" alt="Screenshot 2023-07-15 at 3 00 38 PM" src="https://user-images.githubusercontent.com/110333328/253768216-d20ccbe9-bf17-4e51-87b1-f012b09f536d.png">


* After landing a hit, computer will make an educated guess for its next shot(s) until the ship is sunk
