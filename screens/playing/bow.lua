local check = require "check-self"

---@class Bow # The Bow.
local Bow = {
    ---@type string # class name
    __name__ = "Bow",
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil,
    ---@type number | nil # vertical offset
    dy = nil,
    ---@type Ground | nil # reference to Ground object
    ground = nil,
    ---@type table<"shot"|"empty", love.Source> # Arrow sounds
    sounds = {
        empty = love.audio.newSource("sounds/empty.wav", "static"),
        shot = love.audio.newSource("sounds/shot.wav", "static"),
    }
}

---@param x number # bow's horizontal position
---@param dy number # bow's vertical offset above ground
---@param ground Ground # reference to ground object
---@return Bow
function Bow:new(x, dy, ground)
    check(self, Bow.__name__)
    local mt = { __index = Bow }
    local members = {
        dy = dy,
        ground = ground,
        x = x,
        y = ground.y + dy
    }
    return setmetatable(members, mt)
end

---@return Bow
function Bow:draw()
    check(self, Bow.__name__)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.circle("fill", self.x, self.y, 4)
    return self
end

---@return Bow
function Bow:update()
    check(self, Bow.__name__)
    self.y = self.ground.y + self.dy
    return self
end

return Bow
