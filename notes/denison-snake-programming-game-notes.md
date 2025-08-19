# TODO
- Make a dedicated game document and ask David to review

- modify the vs code launch.json to build before running

- Have people put optional bot information as a comment on the top of their bot:
Name (displayed during the in-person tournament, if you submit multiple bots as the same person names must be unique!)

- Grid needs an api to get the time left.. Perhaps I'll have to pass in the start time to the bots so they can accurately calculate how much they have left.

- Add sounds. fruit eating, a ping every timestep, a crunch sound on loss etc.

- Run a cpp 101 aimed at those who took APCSA to get them up and running for
the competition. Create a script beforehand.

## Creating the tournament software
Create a `cpp` script to automatically compile every bot into a command line
program using the compile_bot target. The compiled bot will be named
first-last-name. `first` and `last` is the creator's name and `name` is the name
written at the top of their file.

- Look for a /tmp/du_slither_current_matches.txt
- If it exists, generate matches from a vec of the following class:
```cpp
/// \brief represents a match. player_one and player_two follow the first-last-name convention.
class Match {
public:
    string get_player_one;
    string get_player_two;
    MatchResult match_result;
    Match(string player_one, string player_two, MatchResult match_result) :
        player_one(player_one), player_two(player_two), match_result(match_result) {}

    operator=
private:
    string player_one;
    string player_two;
}
```

```cpp
/// \brief represents a result for a match between two snakes.
enum class MatchResult {
    PlayerOneWon,
    PlayerTwoWon,
    Draw,
    NotRun,
}
```

- If it doesn't, generate round robin matches for all bots in ./src/tournament/bots. And write to /tmp/du_slither_current_matches.txt.
- Need to generate round robin matches from `vector<string>`
- Create a `vector<Match>` from a string with the format of /tmp/du_slither_current_matches.txt

- in either case, now we have a `vector<Match>`.

- Find if there's an unrun match in 

- Run the game with the following controls:

- Controls: D to start the next match. Space to pause an on-going match. L to step forward. A to bring up the new rankings. S to bring up the next set of bots. Space to unpause.

- Display on screen who is currently going against each other

- Display on screen the reason for the win. E.g going into a wall, ran out of time, 

- Update the text file as each match finishes

Run the snakes on separate processes with a time and resource (cpu + memory)
limit. 

- Whats a way to allow other people to actually test their bot with resource
limits? Could give the tournament program that will be used for running the
bots and letting them see how their performs.

## Done, just needs to merge. will do after Colin's feedback

Instructions for setting command line flags for vs code

Fix heads going into each other being them swapping positions or a win.

After 100 ticks, the longer snake wins.
