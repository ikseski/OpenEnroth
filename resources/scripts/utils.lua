---@class Utilities
local Utilities = {}

---Convert a string to a boolean
---@param value string
---@return boolean
Utilities.toBoolean = function (value)
    return value ~= "false" and value ~= "0"
end

---Convert a variable to a number. in case of failure the defaultValue is returned
---@param amount any
---@param defaultValue number
---@return number
Utilities.toNumberOr = function (amount, defaultValue)
    amount = tonumber(amount)
    return amount and amount or defaultValue
end

--- Tell if a string is empty or nil
---@param s string
---@return boolean
Utilities.isEmpty = function (s)
    return s == nil or s == ""
end

--- Split the string according to the separator, respecting quoted substrings
---@param str string - base string
---@param separator string - separator to be used
---@return table<integer, string> - list of splitted strings
Utilities.splitString = function (str, separator)
    separator = separator or "%s"
    local result = {}
    local len = #str
    local i = 1
    local current = ""
    local inQuotes = false
    local quoteChar = nil
    local hadQuotes = false

    while i <= len do
        local c = str:sub(i, i)

        if inQuotes then
            if c == "\\" and i < len then
                current = current .. str:sub(i + 1, i + 1)
                i = i + 2
            elseif c == quoteChar then
                inQuotes = false
                hadQuotes = true
                i = i + 1
            else
                current = current .. c
                i = i + 1
            end
        else
            if c == '"' or c == "'" then
                inQuotes = true
                quoteChar = c
                hadQuotes = false
                i = i + 1
            elseif c:match(separator) then
                if #current > 0 or hadQuotes then
                    table.insert(result, current)
                    current = ""
                    hadQuotes = false
                end
                i = i + 1
                while i <= len and str:sub(i, i):match(separator) do
                    i = i + 1
                end
            else
                current = current .. c
                i = i + 1
            end
        end
    end

    if #current > 0 or hadQuotes then
        table.insert(result, current)
    end

    return result
end

--- Take an enum table and returns the string representation of the value provided
--- It basically returns the key of the corresponding row
---
--- Example:
--- Game.SkillType = {
---    Club = 0,
---    Sword = 1,
---    Dagger = 2,
--- }
--- local result = enumToString(Game.SkillType, 2)
--- The value of variable "result" is "Dagger"
---
---@param enumTable any - The enum table ( ex: Game.SkillType, Game.SkillMastery )
---@param value any
---@return string
function enumToString(enumTable, value)
    ---@cast enumTable table<string, any>
    for k, v in pairs(enumTable) do
        if v == value then
            return k
        end
    end

    return ""
end

---@param enumTable any - The enum table ( ex: Game.SkillType, Game.SkillMastery )
---@param valueStr string
---@return any
function stringToEnum(enumTable, valueStr)
    ---@cast enumTable table<string, any>
    for k, v in pairs(enumTable) do
        if k == valueStr then
            return v
        end
    end

    return 0
end

---@class Rect
---@field x number
---@field y number
---@field w number
---@field h number

---Create a table with x,y,w,h fields
---@param x number
---@param y number
---@param w number
---@param h number
---@return Rect
Utilities.rect = function (x, y, w, h)
    return {
        x = x,
        y = y,
        w = w,
        h = h
    }
end

---@class Color
---@field r number
---@field g number
---@field b number
---@field a number

---Create a table with r,g,b,a fields
---@param r number
---@param g number
---@param b number
---@param a number
---@return Color
Utilities.color = function (r, g, b, a)
    return {
        r = r,
        g = g,
        b = b,
        a = a
    }
end

---@param table table<any, any>
Utilities.printTable = function (table)
    for k, v in pairs(table) do
        print(k, v)
    end
end

return Utilities
