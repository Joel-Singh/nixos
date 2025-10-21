# DU Slither Project

## Moving Branches Into Binary Options

Going to add two binary options:

"--infinite": Infinitely replays the game.
"--tournament": Executes the tournament main. Not valid with infinite.

Refactor get_player_from_args to be get_args. Returning an Argument struct:

```cpp
struct Arguments {
    const bool infinite;
    const optional<PlayerType> player_type;
    const bool tournament;
}
```

if infinite and tournament, return an error as that isn't valid.

I would need to encode the regular bot main into `versus_main(PlayerType, is_infinite)` and the tournament code into `tournament_main(void)` and then run the corresponding one based upon the arguments.

Lets start with refactoring get_player_from_args to get_args returning an argument struct of: 

```cpp
struct Arguments {
    const bool infinite;
    const PlayerType player_type;
}
```

Without the tournament and optional player type

## TODO
- Limit cpu and memory in run_bot with `ulimit` and `cpulimit`.
- Make a prettier tournament interface including adding sounds.
- Ensure tests compile for windows.
- Write up a plan for teaching the youngin's for the denison snake program tutor and ask for David Khan review.
- Automatic compilation of bots for tournament
- Move all different code paths into different binary options rather than different branches.
