# TODO

Make a dedicated game document and ask David to review

Run the snakes on separate processes with a time and resource (cpu + memory)
limit. Grid would have to have an api to get the time left..

Create a bash script to automatically compile every bot into a command line program which:

## takes in the game information via stdin
It needs:
is_player_one: `bool`
current_tick: `int`
Cell row size: `int`
Cells: `std::vector<std::vector<Cell>>`
player_one_segments: `std::vector<Pos>`
player_two_segments: `std::vector<Pos>`

Uh can just do a bunch of symbols separated by spaces and newlines. Newline indicates a new parameter.

Example stdin:
false \\ is_player_one
32241 \\ current_tick
10 
EMPTY FRUIT PLAYER_ONE PLAYER_TWO... \\ the first number indicates the row length, i.e, each set of ten values is a row.
3 1 3 1 4 5 1 4 1 3 1 4 5 6 5 1 9 3 9 1 \\ every pair of two numbers is a position, the first one is the head. There are an even count of numbers
3 1 3 1 4 5 1 4 1 3 1 4 5 6 5 1 9 3 9 1 \\ every pair of two numbers is a position, the first one is the head. There are an even count of numbers

A pos is:
(x, y)

A Cell is:
```cpp
enum Cell {
  EMPTY,
  FRUIT,
  PLAYER_ONE,
  PLAYER_ONE_HEAD,
  PLAYER_TWO,
  PLAYER_TWO_HEAD
};
```

------------------------------

outputs the direction via stdout

It runs the binary in the background, giving it however many seconds and resource limits

A way to run the game programmatically and keep a running count of the results
as it happens. Round Robin Style. Compile all the bots into a commandline
program. Generate Round Robin matches--automatically playing the games, and
then showing it as a tournament ranking as a graph at the end of each game.

Whats a way to allow other people to actually test their bot with resource
limits? Could give the tournament program that will be used for running the
bots and letting them see how their performs.

## Done, just needs to merge. will do after Colin's feedback

Instructions for setting command line flags for vs code

Fix heads going into each other being them swapping positions or a win.

After 100 ticks, the longer snake wins.
