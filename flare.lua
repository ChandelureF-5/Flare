local flare = {}

local base = (...):match("(.-)[^%.]+$")

local function load(path)
    return require(base .. path)
end

flare.basic = load("core.basic")
flare.gamestate = load("core.gamestate")
flare.object = load("core.object")
flare.signal = load("core.signal")

flare.sprite = load("graphics.sprite")
flare.text = load("graphics.text")
flare.shader = load("graphics.shader")
flare.camera = load("graphics.camera")
flare.video = load("graphics.video")

flare.keyboard = load("input.keyboard")

flare.math = load("math.math")

flare.sound = load("audio.sound")

flare.json = load("data.json")
flare.save = load("data.save")
flare.assets = load("data.assets")

flare.tweens = load("tweens.tweens")

flare.utils = load("utils.utils")
flare.paths = load("utils.paths")

flare.discord = load("discord")

return flare