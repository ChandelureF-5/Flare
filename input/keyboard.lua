local Keyboard = {}

Keyboard.binds = {
    up = { "up", "w" },
    down = { "down", "s" },
    left = { "left", "a" },
    right = { "right", "d" },
    accept = { "return", "space", "z" },
    back = { "escape", "backspace", "x" },
    reload = { "f5" }
}

Keyboard.gamepadBinds = {
    up = { "dpup" },
    down = { "dpdown" },
    left = { "dpleft" },
    right = { "dpright" },
    accept = { "a", "start" },
    back = { "b", "back" }
}

Keyboard.pressed = {}
Keyboard.released = {}

Keyboard.gamepadPressed = {}
Keyboard.gamepadReleased = {}

Keyboard.deadzone = 0.35

function Keyboard.update()
    Keyboard.pressed = {}
    Keyboard.released = {}

    Keyboard.gamepadPressed = {}
    Keyboard.gamepadReleased = {}
end

function Keyboard.keypressed(key)
    Keyboard.pressed[key] = true
end

function Keyboard.keyreleased(key)
    Keyboard.released[key] = true
end

function Keyboard.gamepadpressed(joystick, button)
    Keyboard.gamepadPressed[button] = true
end

function Keyboard.gamepadreleased(joystick, button)
    Keyboard.gamepadReleased[button] = true
end

function Keyboard.down(action)
    for _, key in ipairs(Keyboard.binds[action] or {}) do
        if love.keyboard.isDown(key) then
            return true
        end
    end

    local joysticks = love.joystick.getJoysticks()

    for _, joystick in ipairs(joysticks) do
        for _, button in ipairs(Keyboard.gamepadBinds[action] or {}) do
            if joystick:isGamepadDown(button) then
                return true
            end
        end

        local lx = joystick:getGamepadAxis("leftx")
        local ly = joystick:getGamepadAxis("lefty")

        if action == "up" and ly < -Keyboard.deadzone then
            return true
        elseif action == "down" and ly > Keyboard.deadzone then
            return true
        elseif action == "left" and lx < -Keyboard.deadzone then
            return true
        elseif action == "right" and lx > Keyboard.deadzone then
            return true
        end
    end

    return false
end

function Keyboard.justPressed(action)
    for _, key in ipairs(Keyboard.binds[action] or {}) do
        if Keyboard.pressed[key] then
            return true
        end
    end

    for _, button in ipairs(Keyboard.gamepadBinds[action] or {}) do
        if Keyboard.gamepadPressed[button] then
            return true
        end
    end

    return false
end

function Keyboard.justReleased(action)
    for _, key in ipairs(Keyboard.binds[action] or {}) do
        if Keyboard.released[key] then
            return true
        end
    end

    for _, button in ipairs(Keyboard.gamepadBinds[action] or {}) do
        if Keyboard.gamepadReleased[button] then
            return true
        end
    end

    return false
end

function Keyboard.bind(action, keys)
    Keyboard.binds[action] = keys
end

function Keyboard.bindGamepad(action, buttons)
    Keyboard.gamepadBinds[action] = buttons
end

return Keyboard