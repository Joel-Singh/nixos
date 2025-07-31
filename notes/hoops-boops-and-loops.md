# Hoops & Boops Programming Plan

## List of implementations 

## GameState
```rust
/// GameState::Titlescreen is the initial state
/// GameState::TitleScreenToFirstPlanet is a transition, where there is a zoom in on the planet in the titlescreen
/// GameState::FirstPlanetToMainGame Zooms out to reveal the Main Game
/// GameState::MainGame where you can buy new loops and see *6* planets
enum GameState {
    Titlescreen,
    TitleScreenToFirstPlanet,
    FirstPlanet,
    FirstPlanetToMainGame,
    MainGame
}
```

## CameraTransition
```rust
/// This module will simply have implemented easing for Orthographic projection, giving warning if an easing for a projection that isn't orthagrphic is tried. See https://docs.rs/bevy_easings/0.16.0/src/bevy_easings/implemented.rs.html as an example of how to implement it.
mod implement_projection_easing;

const FIRST_PLANET_CAMERA_ORIGIN: Vec2 = /* */; /// The origin of the camera during the first planet. Also the position of the first planet in world coords

const FIRST_PLANET_ZOOM: f32 = /* */ ; /// Zoom necessary to fill the screen with the first planet

const MAIN_GAME_CAMERA_ORIGIN: Vec2 = /* */; /// The origin of the camera during the main game

const MAIN_GAME_ZOOM: f32 = /* */; /// The origin of the camera during the main game

/// Moves the camera when entering TitleScreenToFirstPlanet or FirstPlanetToMainGame
/// 
/// See https://taintedcoders.com/bevy/cameras for an explanation on the
/// different concepts regarding cameras (viewports, render targets, etc)
/// 
/// Example of camera zooming: https://bevy.org/examples/camera/projection-zoom/
pub fn camera_transition_plugin() {

}
```

## Background
```rust
/// Spawns the background and handles the logic of every effect
pub fn background_plugin() {
}
```

## Titlescreen
```rust

/// Spawns the titlescreen and play btn
pub fn titlescreen_plugin() {

}

```

## LoopBoopHoopPlugin
```rust
#[derive(Component)]
struct Boop {
    loop: Entity,
    current_loop_position: Rot2,
    in_hoop: bool
}

#[derive(Component)]
struct Hoop {
    loop: Entity,
}

#[derive(Component)]
struct Loop {
    boops: Vec<Entity>,
    hoops: Vec<Entity>
}

const MAX_HOOPS: u32 = 8; /// The max number of hoop
const INITIAL_HOOP_POSITION: Rot2 = Rot2::FRAC_PI_8; /// The initial position of the first hoop.

/// Sets up  everything responsible for handling loops boops and hoops
pub fn loop_boop_hoop_plugin(app: &mut App) {
    app.add_systems(
        FixedUpdate,
        (
            move_boops_forward,
            position_boops,
            get_loot_on_boop_in_hoop,
        ).chain()
    ).add_observer(place_hoops_observer);
}

/// Positions boops according to Boop::current_loop_position
pub fn position_boops() {}

/// Moves boops forwards by incrementing Boop::current_loop_percentage
pub fn move_boops_forward() {}

/// Increments loot by 1 whenever a boop enters a hoop
pub fn get_loot_on_boop_in_hoop() {}

#[derive(Command)]
pub struct SpawnLoop(Vec2);

impl Command for SpawnLoop {
    // Spawns a loop with the corresponding boops and hoops at the position of SpawnLoop.0
    // Hoops and Loops will be children of the loop (along with being kept track of in Loops.boops/Loops.hoops) so that their transform is relative to the Loop
}

/// Custom EntityCommand that adds a hoop to a loop
/// The hoop is placed in the INITIAL_HOOP_POSITION, or else, 1/8 from the last one
/// Does nothing and emits warning if you try to add a hoop to a loop that already has 8
pub struct AddHoop;
impl EntityCommand for AddHoop {}

pub struct AddBoop;
impl EntityCommand for AddBoop {}

/// Load randomly "file-#.svg" with the # being replaced by a random number from range.
fn load_random_variant(file: String, range: Range<u32> asset_server: &AssetServer) -> ImageHandle {
    let mut rng = rand::rng();
    return asset_server.load("file-" + rng.random_range(range).to_string() + ".svg")
}
```

## NewBoopAndHoopMoonBtns
```rust
enum BtnType {
    NewHoop,
    NewBoop
}

#[derive(Component)]
struct MoonBtn {
    type: BtnType,
    price: f32,
};

pub fn new_boop_and_hoop_moon_btns_plugin(app: &mut App) {
    // Do all the boilerplate shiz
}

/// Creates a new boop and new hoop btn around the given loop
pub fn create_orbit_moon_buttons(commands: &mut Commands, loop: Entity) {
    // Will attach observers to the NewBoopBtn and NewHoopBtn for the respective buy_new_* function.
}

// If enough loot, decrements loot and calls the AddHoop function. Otherwise, makes a little *err* sound and turns orange briefly.
pub fn buy_new_boop() {}

pub fn buy_new_hoop() {}
```

## LootPlugin
```rust
/// main currency, used to buy more boops and hoops
#[derive(Resource, Deref, DerefMut)]
pub struct Loot(u32);


pub fn loot_plugin(app: &mut App) {
    // boilerplate of adding systems and whatnot
    // spawns the loot ui element
}

/// Show the UI element. Use bevy easings to ease in the transparency so it isn't abrupt
pub fn show() {}

/// Update the loot display
pub fn update_loot_display() {}
```
