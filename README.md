# Flare

A 2D game engine for [LÖVE2D](https://love2d.org) that gives you everything you need in one place.

## Features

- **Gamestates**: stack-based state management with fade transitions and hot reload
- **Sprites**: image rendering with animation support
- **Camera**: 2D camera with shake, zoom, smoothing, and bounds clamping
- **Tweens**: tween any table field with 14 built-in easing functions
- **Physics**: velocity, acceleration, drag, and max velocity via `Object`
- **Audio**: SFX and music playback with per-category volume control
- **Video**: OGV video playback with volume control
- **Input**: keyboard helpers
- **Save**: signed and encoded save data with a user-provided secret key
- **Assets**: cached loading for images, sounds, fonts, shaders, video, JSON, and Lua data
- **Math**: lerp, clamp, remap, approach, distance, angle, overlap, and more
- **Signals**: simple event/observer system
- **Discord**: Discord Rich Presence integration
## Requirements

- [LÖVE2D](https://love2d.org) 11.4 or newer

## Installation

### Manual

Copy the `flare` folder into your project and require it:

```lua
local fl = require("flare")
```

### LuaRocks

```bash
luarocks install flare
```

## Usage

```lua
local fl = require("flare")

-- gamestates
fl.gamestate.register("menu", "states.menu")
fl.gamestate.switch("menu")
fl.gamestate.registerEvents()

-- tweens
fl.tweens.to(myObject, 0.5, { x = 100, alpha = 0 }, "outQuad")

-- audio
fl.sound.init("my_secret_key")
fl.sound.music("assets/sounds/theme.ogg")
fl.sound.play("assets/sounds/jump.ogg")

-- save
fl.save.init("my_secret_key")
fl.save.load()
fl.save.set("coins", 100)

-- camera
local cam = fl.camera.new()
cam:lookAt(player.x, player.y)
cam:attach()
    -- draw world here
cam:detach()
```

## Module Overview

| Module | Path |
|---|---|
| Gamestate | `flare.core.gamestate` |
| Object | `flare.core.object` |
| Basic | `flare.core.basic` |
| Signal | `flare.core.signal` |
| Camera | `flare.graphics.camera` |
| Sprite | `flare.graphics.sprite` |
| Text | `flare.graphics.text` |
| Shader | `flare.graphics.shader` |
| Video | `flare.graphics.video` |
| Sound | `flare.audio.sound` |
| Keyboard | `flare.input.keyboard` |
| Math | `flare.math.math` |
| Assets | `flare.data.assets` |
| Save | `flare.data.save` |
| JSON | `flare.data.json` |
| Tweens | `flare.tweens.tweens` |
| Utils | `flare.utils.utils` |
| Paths | `flare.utils.paths` |
| Discord | `flare.discord` |

## License

MIT: see [LICENSE](LICENSE)
