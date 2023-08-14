local check = require "check-self"

---@class Bullet # The Bullet class.
local Bullet = {
    ---@type string # class name
    __name__ = "Bullet",
    ---@type number # How old the bullet is
    age = 0,
    ---@type boolean # Whether the bullet is still alive
    alive = true,
    ---@type number[] # RGBA brightness
    color = {0, 128, 128, 255},
    ---@type number | nil # bullet radius
    radius = 2,
    ---@type number | nil # horizontal speed
    u = nil,
    ---@type number | nil # vertical speed
    v = nil,
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil
}

---@param u number # horizontal speed of the bullet
---@param v number # vertical speed of the bullet
---@param x number # horizontal position of the bullet
---@param y number # vertical position of the bullet
---@return Bullet
function Bullet:new(x, y, u, v)
    check(self, Bullet.__name__)
    local mt = { __index = Bullet }
    local members = {
        u = u,
        v = v,
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

---@return Bullet
function Bullet:draw()
    check(self, Bullet.__name__)
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    return self
end

---@param dt number # Time elapsed since last frame (seconds)
---@return Bullet
function Bullet:update(dt)
    check(self, Bullet.__name__)
    self.age = self.age + dt
    self.v = self.v + 0.5 * State.GRAVITY_ACCELERATION * dt * dt
    self.u = self.u
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
    -- check bounds
    local width, height = love.graphics.getDimensions()
    self.alive = self.alive and
                 self.age < 15 and
                 self.x > 0 and
                 self.x < width and
                 self.y > 0 and
                 self.y < height
    return self
end

return Bullet
