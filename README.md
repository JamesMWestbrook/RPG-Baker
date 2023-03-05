# RPG-Baker
A Godot plugin meant to build the simplicity and workflow of RPG Maker-like engines with the flexibiity and opportunity for expansion with Godot. Ideally it will have the best of both worlds, not needing "code" to do most basic things, but still being able to be easily expanded on if you don't mind writing your own code in GDScript.

Uses latest version of Godot 4.

You will need basic knowledge of Godot's dozens of different Node types, but you will not be required to use GDScript for basic functionality through them.

## Disclaimer: This is heavily inspired mostly by [RPG Architect](https://store.steampowered.com/app/2158670/RPG_Architect/), which is run by a solo developer. If RPG Baker does not interest you consider supporting this developer instead :)
* (You'll actually find me in his discord server)
* I don't need to tell you the source of both our inspirations is RPG Maker, which needs no links for you to be able to find it and it's many different engines over the past few decades.


## To-Do
* In Game UI
    * Dialog. This plugin will be making use of [Dialogic 2](https://github.com/coppolaemilio/dialogic), which is currently incompatible with this project. Once it is compatible I will be adding functionality to make use of its robust visual novel-like systems.
        * When reasonable, I will be forgoing making brand new systems on my own if there is a simpler way to do it provided by the engine, examples being SpriteFrames and Dialogic. We are not reinventing the wheel.
* On Map
    * After Party logic is implemented, base player graphics on Party Leader.
    * Sprint button.
    * Option to have extra animations to cover "Sprint" mode.
    * Party Followers
        * Bonus, whether they follow in a direct line or in a horizontal row behind you.
* Party
    * Have a party list that can be checked independently of Game_Actors. Located in Database.
* Events
    * Trigger event by "examine" action.
* Battle
    * CURRENT: RPG Stats
        * Table for setting stats per level
        * Feature to use formula to autofill table
    * Basic turn based combat.
    * ATB/Counter combat system.
    * No intentions currently of adding on-map battle like Zelda or other map based combat games. 
* Classes
    * Option to set different stat curve based on Primary/Secondary/etc class
## Completed
* Events
    * Basic Variable + Switch assignment
    * Conditional checks on Variables/Switches
    * Modify RPG Stats on actor
* In Game UI
    * 3/3/22: Nodes dedicated to showing X actor graphic via the global actor list. 
* On Map
    * Player can move.
    * Player graphic auto assigned to Actor 1(index 0).
    * "Events" can be triggered by touch.
* Actors
    * Name, Nickname, Profile, Classes
    * Map Sprites, Bust/Portrait Sprites, Battle Sprites through Godot's [SpriteFrames](https://docs.godotengine.org/en/latest/classes/class_spriteframes.html#class-spriteframes) resource. 
        * Bust/Battle Sprites can also be set to be a single image(.jpg,.png) rather than a SpriteFrame resource.
* Classes
    * Name, Description, can add sprites in same fashion as Actor, Assign Traits
    * Class sprites come into play via a Trait that allows you to override a specific Actor sprite layer by the Class's same layer index.
### Please note while this is currently in development, I am not under the expectation for anyone to actually use this. Please reach out to me through the below link if you need help figuring out this plugin.
## Bunch of stuff I want to do EVENTUALLY. If you are using RPG Baker and plan on needing one of the below features please reach out to me in my [discord](https://discord.gg/nQecYmP) so I may consider adding priority.
* Allow extra animation via SpriteFrame animations to support diagonal animation(You can already MOVE diagonally). 
    * Normally you have 4 animations up/down/left/right, you would be adding an additional 4: upleft,upright,downleft,downright.
    * Once sprint-specific animations are implemented this would add another 4 to be added to specify direction as well as when sprinting.
