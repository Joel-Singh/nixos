# TODO
- Make a dedicated game document and ask David to review

- Have people put optional bot information as a comment on the top of their bot:
Name (displayed during the in-person tournament, if you submit multiple bots as the same person names must be unique!)

- Add sounds. fruit eating, a ping every timestep, a crunch sound on loss etc.

## Creating the tournament software
manually compile every bot into a command line program using the compile_bot
target. The compiled bot will be named first-last-name. `first` and `last` is
the creator's name and `name` is the name written at the top of their file.

- Look for a /tmp/du_slither_current_matches.txt
- If it exists, generate matches from a vec of `Match`:
- If it doesn't, generate round robin matches for all bots in ./src/tournament/bots. And write to /tmp/du_slither_current_matches.txt.
- Need to generate round robin matches from `vector<string>`
- Create a `vector<Match>` from a string with the format of /tmp/du_slither_current_matches.txt

- in either case, now we have a `vector<Match>`.

- Find if there's an unrun match in `/tmp/du_slither_current_matches.txt`

- Run the game with the following controls:

- Controls: D to start the next match after the previous has ended. L to step forward. A to print the current rankings to std out. Space to unpause.

- Display on screen who is currently going against each other
- Display on screen the reason for the win. E.g going into a wall, ran out of time, 

- Update the text file as each match finishes

### Pseudocode
```
- Get all possible matches
processed_game_end = false;
player_one = ...
player_two = ...
while true {
    Input input = getInput();

    if (input.L & gamestate == not done) {
        process game for one tick
    }

    if (gamestate == done & !processed_game_end) {
        curMsg = loss_reason;
        update match file;
    }

    if (D & gamestate == done) {
        processed_game_end = false;
        reset_board_state(...);
        randomly load next match replacing player_one and player_two bots;
    }

    if (A) {
        printRanking();
    }

    drawboard();
    drawMsg();
}

```


### TODO
- Limit cpu and memory in run_bot with `ulimit` and `cpulimit`
- Refactor `compute_game_logic` to return loss reason
- Refactor `run_bot` to return loss reason
- Implement `printRanking(matches)`
- Implement `drawMsg(msg)`
- `resetGame(...)` taking in all needed game variables
