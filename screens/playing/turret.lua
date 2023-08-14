local check = require "check-self"

---@class Turret # The Turret.
local Turret = {
    ---@type string # class name
    __name__ = "Turret",
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil,
    ---@type number | nil # vertical offset
    dy = nil,
    ---@type Ground | nil # reference to Ground object
    ground = nil,
    ---@type table<"shot"|"empty", love.Source> # Turret sounds
    sounds = {
        empty = love.audio.newSource("sounds/empty.wav", "static"),
        shot = love.audio.newSource("sounds/shot.wav", "static"),
    }
}

---@param x number # turret's horizontal position
---@param dy number # turret's vertical offset above ground
---@param ground Ground # reference to ground object
---@return Turret
function Turret:new(x, dy, ground)
    check(self, Turret.__name__)
    local mt = { __index = Turret }
    local members = {
        dy = dy,
        ground = ground,
        x = x,
        y = ground.y + dy
    }
    return setmetatable(members, mt)
end

---@return Turret
function Turret:draw()
    check(self, Turret.__name__)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.circle("fill", self.x, self.y, 4)
    return self
end

---@return Turret
function Turret:update()
    check(self, Turret.__name__)
    self.y = self.ground.y + self.dy
    return self
end

return Turret
