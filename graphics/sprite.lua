local Object = require("core.object")
local Assets = require("data.assets")

---@class Sprite : Object
---@field image love.Image?
---@field scale {x:number, y:number}
---@field origin {x:number, y:number}
---@field color number[]
local Sprite = setmetatable({}, { __index = Object })
Sprite.__index = Sprite

---Creates a new sprite.
---@param x? number X position.
---@param y? number Y position.
---@param imagePath? string|love.Image Image path or image object.
---@return Sprite
function Sprite.new(x, y, imagePath)
    local self = Object.new(x or 0, y or 0, 0, 0)
    setmetatable(self, Sprite)

    self.image = nil
    self.scale = { x = 1, y = 1 }
    self.origin = { x = 0, y = 0 }
    self.color = { 1, 1, 1, 1 }

    if imagePath then
        self:loadGraphic(imagePath)
    end

    return self
end

---Sets the sprite scale.
---@param x number Horizontal scale.
---@param y? number Vertical scale. Uses x if omitted.
---@return Sprite
function Sprite:setScale(x, y)
    self.scale.x = x
    self.scale.y = y ~= nil and y or x
    return self
end

---Centers the sprite on screen.
---@param axes? string "x", "y", or "xy".
---@return Sprite
function Sprite:screenCenter(axes)
    local sw, sh = love.graphics.getDimensions()

    axes = axes or "xy"

    if axes:find("x") then
        self.x = (sw - self.width * self.scale.x) / 2
    end

    if axes:find("y") then
        self.y = (sh - self.height * self.scale.y) / 2
    end

    return self
end

---Loads a graphic into the sprite.
---@param path string|love.Image Image path or image object.
---@return Sprite
function Sprite:loadGraphic(path)
    if type(path) == "string" then
        self.image = Assets.image(path)
    else
        self.image = path
    end

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    return self
end

---Draws the sprite.
function Sprite:draw()
    if not self.image then return end

    love.graphics.setColor(self.color)
    love.graphics.draw(self.image, self.x, self.y, self.angle or 0, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
    love.graphics.setColor(1, 1, 1, 1)
end

return Sprite