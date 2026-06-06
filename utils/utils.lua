local Utils = {}

---Simple switch statement.
---@generic T
---@param value T
---@param cases table<T, fun():any>
---@return any
function Utils.switch(value, cases)
    local case = cases[value]

    if case then
        return case()
    end

    if cases.default then
        return cases.default()
    end
end

---Rounds a number.
---@param num number
---@param decimals? integer
---@return number
function Utils.round(num, decimals)
    decimals = decimals or 0
    local mult = 10 ^ decimals
    return math.floor(num * mult + 0.5) / mult
end

---Clamps a value between min and max.
---@param value number
---@param min number
---@param max number
---@return number
function Utils.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

---Linear interpolation.
---@param a number
---@param b number
---@param t number
---@return number
function Utils.lerp(a, b, t)
    return a + (b - a) * t
end

---Checks if value exists in table.
---@param tbl table
---@param value any
---@return boolean
function Utils.contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

---Returns the number of entries in a table.
---@param tbl table
---@return integer
function Utils.tableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

---Deep copy a table.
---@param original table
---@return table
function Utils.deepCopy(original)
    local copy = {}

    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utils.deepCopy(v)
        else
            copy[k] = v
        end
    end

    return copy
end

---Returns a random element from a table.
---@param tbl table
---@return any
function Utils.randomChoice(tbl)
    return tbl[love.math.random(#tbl)]
end

---Shuffles a table in-place.
---@param tbl table
---@return table
function Utils.shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = love.math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

---Formats a number with commas.
---@param num number
---@return string
function Utils.commaValue(num)
    local formatted = tostring(num)

    while true do
        formatted, k = string.gsub(
            formatted,
            "^(-?%d+)(%d%d%d)",
            "%1,%2"
        )

        if k == 0 then
            break
        end
    end

    return formatted
end

---Returns sign of a number.
---@param n number
---@return integer
function Utils.sign(n)
    if n > 0 then return 1 end
    if n < 0 then return -1 end
    return 0
end

---Maps a value from one range to another.
---@param value number
---@param inMin number
---@param inMax number
---@param outMin number
---@param outMax number
---@return number
function Utils.map(value, inMin, inMax, outMin, outMax)
    return (value - inMin) * (outMax - outMin) / (inMax - inMin)+ outMin
end

---Returns true if string starts with prefix.
---@param str string
---@param prefix string
---@return boolean
function Utils.startsWith(str, prefix)
    return str:sub(1, #prefix) == prefix
end

---Returns true if string ends with suffix.
---@param str string
---@param suffix string
---@return boolean
function Utils.endsWith(str, suffix)
    return suffix == "" or str:sub(-#suffix) == suffix
end

---Converts boolean to On/Off text.
---@param value boolean
---@return string
function Utils.boolText(value)
    return value and "On" or "Off"
end


---Opens a URL in the user's default browser.
---@param url string
---@return boolean success
function Utils.openURL(url)
    if type(url) ~= "string" or url == "" then
        return false
    end

    if not url:match("^https?://") then
        url = "https://" .. url
    end

    love.system.openURL(url)
    return true
end
---Returns a CPU Name.
---@return string
function getCPUName()
    if love.system.getOS() ~= "Windows" then
        return "Unsupported OS"
    end

    local handle = io.popen('wmic cpu get Name /value')

    if handle then
        local result = handle:read("*a")
        handle:close()

        local name = result:match("Name=(.-)\r?\n")

        if name and name ~= "" then
            return name
        end
    end

    local ps = io.popen('powershell -Command "(Get-CimInstance Win32_Processor).Name"')

    if ps then
        local result = ps:read("*a")
        ps:close()

        result = result:gsub("^%s+", ""):gsub("%s+$", "")

        if result ~= "" then
            return result
        end
    end

    return "Unknown"
end
return Utils