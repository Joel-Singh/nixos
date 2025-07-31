
# TODO
Gonna have to remember to write proper cpp documentation for everything

Gonna have to specifically say which standard libraries you can import

Add a get method using position to Grid

Branch src/* into lib. So that everything that the student doesn't need to look at, is in lib

Write an evil bot. Get a review from Violet where you tell her to try to make a `MyBot.cpp` (give a deadline + make a reminder to remind her.) Get a review from David on the README.

Fix heads (with possibly either having more segments) going into each other being them swapping positions or a win.

-------------------

# Needs coding
Write proper cpp documentation generated as viewable in the browser

Display the winner somehow

Write better template bots for MyBot and EvilBot

# Going to code after as nice to haves (Move these into issues on the repo eventually)
- Will be done after creating documentation and whatnot and sending to David and Violet to review.
- Create a "lib" and "bots" folder inside of src to make it easier for users

## The main loop

- Read the options from the command line (`--evil-bot`, `--yourself`, or `--my-bot`)
- Also option (`--manual`) for progressing each game state manually with space
- Create player one and player two accordingly
- Every second, run the compute game logic function

# Implementing flags
Have a `get_player_2_from_commandline_args`. Validates command line parameters, throwing if incorrect, and then returns who the next player is.

Returns an Enum: EvilBot, MyBot, or Manual.

How will the self player work?

can have a if manual player then:

GameState run_two_bot_game(cells, player_one_segments, player_two_segments, Bot &const player_one, const &player_two, &const game_ticks) {

}

else

GameState run_game_with_manual(&cells, &player_one_segments, &player_two_segments, &game_ticks) {

}

## Input
Create an input struct  
struct Input {
    bool is_up_pressed;
    bool is_down_pressed;
    bool is_left_pressed;
    bool is_right_pressed;
}

then in `run_game_with_manual`:

```cpp
void run_game_with_manual(&input/* ... */) {
    std::optional<Direction> manual_player_dir;
    if (input.is_right_pressed) {
        manual_player_dir = Direction::RIGHT;
        input.is_right_pressed = false;
    } // ...

    if (manual_player_dir.is_some()) {
        // do the usual stuff
        game_ticks++;
    }
}
```
