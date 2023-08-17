local check = require "mbm.shared.check-self"

---@class Balloon
local Balloon = {
    ---@type string # class name
    __name__ = "Balloon",
    ---@type number | nil # How old the balloon is
    age = nil,
    ---@type boolean # Whether the balloon is still alive
    alive = true,
    ---@type number[] # array of RGBA brightness
    color = {0, 128, 128, 255},
    ---@type number | nil # balloon radius
    radius = nil,
    ---@type table<"pop"|"score", love.Source> # balloon sounds
    sounds = {},
    ---@type number # horizontal speed
    u = 0,
    ---@type number # vertical speed
    v = 0,
    ---@type number | nil # value
    value = nil,
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil
}

---@return Balloon
function Balloon:new(x, y, u, v, color, radius, sounds, value)
    check(self, Balloon.__name__)
    local mt = { __index = Balloon }
    local members = {
        age = 0,
        color = color,
        radius = radius,
        sounds = sounds,
        u = u,
        v = v,
        value = value,
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

---@return Balloon
function Balloon:draw()
    check(self, Balloon.__name__)
    love.graphics.setColor(self.color)
    local hitbuffer_factor = 1.2
    love.graphics.arc("fill", self.x, self.y, self.radius / hitbuffer_factor, 0.75 * math.pi, math.pi * 2.25)
    --love.graphics.circle("fill", self.x, self.y, self.radius / hitbuffer_factor)
    local vertices = {
        self.x, self.y,
        self.x + self.radius / hitbuffer_factor / math.sqrt(2),  self.y + self.radius / hitbuffer_factor / math.sqrt(2),
        self.x, self.y + self.radius,
        self.x - self.radius / hitbuffer_factor / math.sqrt(2),  self.y + self.radius / hitbuffer_factor / math.sqrt(2),
    }
    love.graphics.polygon("fill", vertices)
    return self
end

---@return Balloon
function Balloon:update(dt)
    check(self, Balloon.__name__)
    self.age = self.age + dt
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
    -- check bounds
    local width, height = love.graphics.getDimensions()
    self.alive = self.alive and
                 self.age < 35 and
                 self.x + self.radius > 0 and
                 self.x - self.radius < width and
                 self.y + self.radius > 0 and
                 self.y - self.radius < height
    return self
end

return Balloon