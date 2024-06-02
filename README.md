# Simple CardPileUI

This plugin provides a flexible and customizable card pile user interface for the Godot game engine. It is designed to handle various card-related functionalities including drawing, discarding, and managing different piles.

![Screenshot](assets/screenshot.png)

![Screenshot2](assets/screenshot2.png)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Concepts](#concepts)
- [Documentation](#documentation)
	- [CardPileUI Properties](#card-pile-ui-properties)
	- [CardPileUI Methods](#card-pile-ui-methods)
	- [CardPileUI Signals](#card-pile-ui-signals)
	- [CardDropzone Methods](#card-dropzone-methods)
	- [CardDropzone Properties](#card-dropzone-properties)
- [Thanks](#thanks)
- [Changelog](#change-log)


<a name="features"></a>
## Features:
- ⚙️ **Configurable Parameters** : Easily customize the behavior of the card pile UI using exported parameters, such as card speed, maximum hand size, display and more.
- 📂 **Simple JSON Loading**: Load card data from a JSON file to populate the card pile.
- 🗃️ **Intuitive Pile Management**: Manage different card piles, including draw, hand, discard.
- 🎉 **Fun UI Elements**: Card interaction is snappy, responsive, and fun out-of-the box, allowing you to skip the boring setup and get started with your game.

<a name="installation"></a>
## Installation

1. Download latest release
2. Unpack the addons/simple_card_pile_ui folder into your /addons folder within the Godot project
3. Enable this addon within the Godot settings: Project > Project Settings > Plugins

<a name="getting-started"></a>
## Getting Started

1. Create a custom resource script extending `CardUIData` that describes any custom properties your card will need. You can utlize inheritance here as needed.
2. Create a database of your card information ([more info](#card-database))([example](#json-database)).
3. Create a collection of your cards ([more info](#card-collection))([example](#json-collection)).
4. Create a new scene with root type `CardUI` - this is the object that displays in game. This object must have 2 TextureRect as children named `Frontface` and `Backface`. It will warn you if configured incorrectly.
5. Add a `CardPileUI` node to your game scene and configure its settings.
6. Begin building your game with the provided methods and signals.

<a name="concepts"></a>
## Concepts
**Card Pile UI** - this is the manager for all cards in a collection.

**Card UI Data** - this represents any custom data that your cards use.

**Card Database** - container for all possible cards, represented by their `CardUIData`

**Card Collection** - container for all cards currently in the game, ie. the deck. Can contain duplicates if the same card is present in the deck multiple times.

**Card UI** - this is the in-game representation of your card data, this holds and displays **Card UI Data**

**Card Dropzone** - this is a designated space where if a player drops a card something occurs. It can also stack cards, removing them from the standard draw/hand/discard piles.

**Draw Pile** - this is a pile containing cards that a player draws from during the game.

**Hand Pile** - this is a pile containing cards currently held by a player.
1
**Discard Pile** - this is a pile containing cards that have been discarded during the game.

**Card Removal from Game**, this occurs when a card is permanently removed from play

<a name="documentation"></a>
## Documentation

<a name="card-pile-ui-properties"></a>
### CardPileUI Properties

| Type                          | Name                            | Default                          | Description                                                                                                                             |
|-------------------------------|---------------------------------|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| *Top Level*                   | -                               | -                                |                                                                                                                                         |
| `CardDB`                      | `card_database`                 | `null`                           | Instance of card database containing card information                                                                                   |
| `String` **_(deprecated)_**     | `json_card_database_path`       | `null`                           | For backwards compatibility only, use `card_database` instead                                                                           |
| `CardCollection`              | `card_collection`               | `null`                           | Instance of card collection containing the current deck                                                                                 |
| `String` **_(deprecated)_**     | `json_card_collection_path`     | `null`                           | Defines the file path for the JSON file containing the card collection. For backwards compatibility only, use `card_collection` instead |
| `PackedScene`                 | `extended_card_ui`              | `null`                           | A PackedScene for your extended `CardUI` scene.                                                                                         |
| *Pile Positions*              | -                               | -                                |                                                                                                                                         |
| `Vector2`                     | `draw_pile_position`            | `Vector2(20, 460)`               | Determines the position of the draw pile on the game screen.                                                                            |
| `Vector2`                     | `hand_pile_position`            | `Vector2(630, 460)`              | Determines the position of the hand pile on the game screen.                                                                            |
| `Vector2`                     | `discard_pile_position`         | `Vector2(1250, 460)`             | Determines the position of the discard pile on the game screen.                                                                         |
| *Pile displays*               | -                               | -                                |                                                                                                                                         |
| `int`                         | `stack_display_gap`             | `8`                              | Sets the gap between displayed cards in a stack.                                                                                        |
| `int`                         | `max_stack_display`             | `6`                              | Defines the maximum number of cards displayed in a stack.                                                                               |
| *Cards*                       | -                               | -                                |                                                                                                                                         |
| `float`                       | `card_speed`                    | `0.1`                            | Sets the speed at which cards move within the game.                                                                                     |
| *Draw Pile*                   | -                               | -                                |                                                                                                                                         |
| `bool`                        | `click_draw_pile_to_draw`       | `true`                           | Clicking the draw pile will trigger the `draw` method                                                                                   |
| `bool`                        | `cant_draw_at_hand_limit`       | `true`                           | If hand is at max capacity, then the `draw` method is ignored. Otherwise cards that are drawn are immediately discarded                 |
| `bool`                        | `shuffle_discard_on_empty_draw` | `true`                           | Enables automatic shuffling of the discard pile into the draw pile when the draw pile is empty.                                         |
| `CardPileUI.PilesCardLayouts` | `draw_pile_layout`              | `CardPileUI.PilesCardLayouts.up` | Determines which direction the pile stacks                                                                                              |
| *Hand Pile*                   | -                               | -                                |                                                                                                                                         |
| `bool`                        | `hand_enabled`                  | `true`                           | Enables or disables the hand pile functionality.                                                                                        |
| `bool`                        | `hand_face_up`                  | `true`                           | Determines whether cards in the hand pile are face up or face down.                                                                     |
| `int`                         | `max_hand_size`                 | `10`                             | Sets the maximum size of the hand. If exceeded, additional cards are immediately discarded.                                             |
| `int`                         | `max_hand_spread`               | `700`                            | Specifies the maximum spread distance of cards in the hand.                                                                             |
| `int`                         | `card_ui_hover_distance`        | `30`                             | Defines the distance at which the card UI responds to hover actions.                                                                    |
| `Curve`                       | `hand_rotation_curve`           | `null`                           | A curve for hand rotation. This works best as a 2-point line, rising linearly from -Y to +Y.                                            |
| `Curve`                       | `hand_vertical_curve`           | `null`                           | A curve for vertical hand movement. This works best as a 3-point line, easing in/out from 0 to Y to 0                                   |
| *Discard Pile*                | `-`                             | -                                |                                                                                                                                         |
| `bool`                        | `discard_face_up`               | `true`                           | Determines whether cards in the discard pile are face up or face down.                                                                  |
| `CardPileUI.PilesCardLayouts` | `discard_pile_layout`           | `CardPileUI.PilesCardLayouts.up` | Determines which direction the pile stacks                                                                                              |

<a name="card-pile-ui-methods"></a>
### CardPileUI Methods

| Return          | Name                                                                   | Description                                                                       |
|-----------------|------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| `void`          | `create_card_in_dropzone(nice_name : String, dropzone : CardDropzone)` | Creates a new instance of the named card in the given dropzone                    |
| `void`          | `create_card_in_pile(nice_name : String, pile_to_add_to : Piles)`      | Creates a new instance of the named card in the given pile                        |
| `void`          | `discard_at(index : int)`                                              | Perform a typical "discard" action, moving card from the hand to the discard pile |
| `void`          | `draw(amount : int = 1)`                                               | Perform a typical "draw" action, moving cards from the draw pile to the hand      |
| `bool`          | `hand_is_at_max_capacity()`                                            | Checks if hand is at max_capacity (any more cards added to it will be discarded)  |
| `CardDropzone`  | `get_card_dropzone(card : CardUI )`                                    | Returns the current dropzone of a given card                                      |
| `CardUI`        | `get_card_in_pile_at(pile : Piles, index : int)`                       | Returns a piles card at a given index                                             |
| `Array[CardUI]` | `get_cards_in_pile(pile : Piles)`                                      | Returns an array of cards from the specified pile                                 |
| `int`           | `get_card_pile_size(pile : Piles)`                                     | Returns the number of cards in a given pile                                       |
| `void`          | `remove_card_from_game(card : CardUI)`                                 | Removes the specified card from the game                                          |
| `void`          | `reset()`                                                              | Resets all cards to the collection's initial state                                |
| `void`          | `set_card_dropzone(card : CardUI, dropzone : CardDropzone)`            | Moves the specified card to the designated CardDropzone                           |
| `void`          | `set_card_pile(card : CardUI, pile : Piles)`                           | Moves the specified card to the designated pile                                   |
| `void`          | `sort_hand(sort_func : Callable)`                                      | Sort the hand using a custom function                                             |

<a name="card-pile-ui-signals"></a>
## CardPileUI Signals

| Signal                                                              | Description                                                   |
|---------------------------------------------------------------------|---------------------------------------------------------------|
| `draw_pile_updated`                                                 | Indicates that the draw pile has been updated                 |
| `hand_pile_updated`                                                 | Indicates that the hand pile has been updated                 |
| `discard_pile_updated`                                              | Indicates that the discard pile has been updated              |
| `card_removed_from_dropzone(dropzone : CardDropzone, card: CardUI)` | Signals the removal of a card from the specified CardDropzone |
| `card_added_to_dropzone(dropzone : CardDropzone, card: CardUI)`     | Signals the addition of a card to the specified CardDropzone  |
| `card_hovered(card: CardUI)`                                        | Indicates when a card is being hovered over                   |
| `card_unhovered(card: CardUI)`                                      | Indicates when a card is no longer being hovered over         |
| `card_clicked(card: CardUI)`                                        | Signals a click event on a card                               |
| `card_dropped(card: CardUI)`                                        | Signals when a clicked card has been dropped                  |
| `card_removed_from_game(card: CardUI)`                              | Signals the removal of a card from the overall game           |

---

<a name="card-dropzone-properties"></a>
### CardDropzone Properties
| Type                          | Name                  | Default                          | Description                                               |
|-------------------------------|-----------------------|----------------------------------|-----------------------------------------------------------|
| `CardPileUI`                  | `card_pile_ui`        | `null`                           | Path to the dropzone's managing CardPileUI node           |
| `bool`                        | `card_ui_face_up`     | `true`                           | Indicates if piled cards should be face up                |
| `int`                         | `stack_display_gap`   | `8`                              | Sets the gap between displayed cards in a stack.          |
| `int`                         | `max_stack_display`   | `6`                              | Defines the maximum number of cards displayed in a stack. |
| `CardPileUI.PilesCardLayouts` | `discard_pile_layout` | `CardPileUI.PilesCardLayouts.up` | Determines which direction the pile stacks                |

<a name="card-dropzone-methods"></a>
### CardDropzone Methods
| Return          | Name                                | Description                                                                                                                                                |
|-----------------|-------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `bool`          | `can_drop_card(card_ui : CardUI)`   | This determines if a card can be dropped on this dropzone. Note - this is only automatically checked when dropping a card, not programatically moving one. |
| `void`          | `card_ui_dropped(card_ui : CardUI)` | This triggers when a card has been added or dropped on this dropzone.                                                                                      |
| `CardUI`        | `get_card_at(index : int)`          | Returns the card at index                                                                                                                                  |
| `Array[CardUI]` | `get_held_cards()`                  | Returns an array of all held cards                                                                                                                         |
| `CardUI`        | `get_top_card()`                    | Returns the top card, which is the same thing as the last one in the array                                                                                 |
| `int`           | `get_total_held_cards()`            | Returns the total number of cards piled here                                                                                                               |
| `bool`          | `is_holding(card : CardUI)`         | Returns true if this card is piled here                                                                                                                    |

<a name="card-ui-data"></a>
### `CardUIData`
`CardUIData` is a resource representing the information to display and
use a single card. It can be subclassed as necessary to store more
information relevant to your game, but at the minimum, it needs the
following information stored in its properties:

* `frontface_texture` - `Texture2D` which will be used by `CardUI` to present the obverse (front) of the card
* `backface_texture` - `Texture2D` which will be used by `CardUI` to present the reverse (back) of the card
* `nice_name` - Human-readable name for the card. Stock `CardUI` does
  not show it by default, but the UI scene provided to `CardPileUI`
  can make use of it (see `example/`)

<a name="card-database"></a>
### Card Database
`CardDB` serves as the foundation for all card data in your game. It
is a `Resource` responsible for loading the `CardUIData` for all cards
that `CardPileUI` will use, and is the abstract base for all
implementations which actually do the loading and retrieval.

Any `CardDB` implementation needs to provide two methods:

* `prepare()` - will be called at least once, before `CardPileUI`
  makes any calls to `get_card()`. This allows the implementation to
  perform any loading and/or processing that it might need to do
* `get_card(card_id) -> CardUIData` - this will be called whenever
  `CardPileUI` needs to access per-card data, and should return an
  instance of `CardUIData` (or its subclass). `card_id` is an opaque
  key that this database can understand. It can be anything the
  implementation wishes to use. Since the key data are provided by the
  caller code, `CardPileUI` does not know or care what they are. The
  only restriction is that the `CardCollection` used (see below) must
  contain keys the `CardDB` being used will understand

There are two built-in implementations of `CardDB`:
* `NullCardDB` - this implementation simply returns any `card_id` it
  receives as-is and performs no loading or retrieval at all. This is
  very useful if you already have a card storage system (for example,
  as custom resources), and simply want to integrate `CardPileUI` into
  your code
* `JSONFileCardDB` - this is a database which loads its data from a
  JSON file and uses strings representing card names as `card_id`

**NOTE**: Earlier versions of `CardPileUI` had hardcoded loading of
JSON files for the card database and collection. If you wish to
continue using JSON files, it is recommended to migrate to
`JSONFileCardDB` and `JSONFileCardCollection`. For backwards
compatibility, if your code does not provide a database/collection and
uses the deprecated JSON path properties, the JSON implementation will
automatically be used as a fallback.

<a name="json-database"></a>
#### `JSONFileCardDB`

`JSONFileCardDB` loads its card data from a JSON file, specified as a
path. At least the following keys are required as a minimally viable
card database:
```
[
  {
	"nice_name": "My Card",
	"texture_path": "res://path/to/card_front.png",
	"backface_texture_path": "res://path/to/card_back.png",
	"resource_script_path": "res://path/to/card_data.gd"
  }
]
```

| Name                    | Description                                                                                                                                                  |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `nice_name`             | A unique name for this card                                                                                                                                  |
| `texture_path`          | Filepath to the card's front texture. Will be `load()`ed                                                                                                     |
| `backface_texture_path` | Filepath to the card's back texture. Will be `load()`ed                                                                                                      |
| `resource_script_path`  | Filepath to the card's resource script. If you don't need any custom functionality, you can point this to `res://addons/simple_card_pile_ui/card_ui_data.gd` |
| *                       | You can add more data as needed                                                                                                                              |


<a name="card-collection"></a>
### `CardCollection`
This represents the cards that begin in the draw pile (ie. the
deck). Like `CardDB`, `CardCollection` is an abstract base class with
a number of possible implementations. It only needs to provide one
method:

* `_get_all()` - getter for the `all` property, this should return a
  list of all the cards in the deck, represented by their IDs
  (ie. values which can be passed to `CardDB.get_card()`). For that
  reason, the `CardCollection` being used needs to be compatible with
  the `CardDB` in use

There are two built-in implementations provided out of the box:

* `JSONFileCardCollection` - loads and returns array of strings from
  the provided JSON file path. Compatible with `JSONFileCardDB`
* `NullCardCollection` - simply returns whatever was provided as its
  `cards` property. Compatible with `NullCardDB`

<a name="json-collection"></a>
#### `JSONFileCardCollection`

This implementation stores a list of strings which should correspond
to the `nice_name`s of cards in the database. Example:
```
 [ "My Card", "My Card", "My Other Card", "My Other Card" ]
```

## To Do List
- Add support for multiple hands to use the same card pile
- Add more shuffle methods
- Add more sort methods
- Document new properties/methods into the read me
- Add different icons for dropzones/debugger
- Add different layout options for dropzones

<a name="thanks"></a>
## Thanks to
- https://andrewvickerman.com
- https://www.kenney.nl
- https://linktr.ee/bramwellgames
- https://www.reddit.com/r/godot

---

<a name="change-log"></a>

## Changelog

### 1.1.0 (2024-02-02)
- Updates CardUI to work better

### 1.0.1 (2024-02-01)
- Removes lerp when clicking a card
- Fixes dropzone top card hover triggering when a card is clicked
- Adds layout directions to piles and dropzones

### 1.0.0 (2024-01-31)
- Initial release
