local Base = require "knife.base"

---@class Bullet # The Bullet class.
local Bullet = Base:extend()


---@param u number # horizontal speed of the bullet
---@param v number # vertical speed of the bullet
---@param x number # horizontal position of the bullet
---@param y number # vertical position of the bullet
---@return Bullet
function Bullet:constructor(x, y, u, v)
    ---@type number             # How old the bullet is
    self.age = 0

    ---@type boolean            # Whether the bullet is still alive
    self.alive = true

    ---@type number[]           # RGBA brightness
    self.color = {0, 128, 128, 255}

    ---@type number             # bullet radius
    self.radius = 2

    ---@type number             # horizontal speed
    self.u = u

    ---@type number             # vertical speed
    self.v = v

    ---@type number             # horizontal position
    self.x = x

    ---@type number             # vertical position
    self.y = y

    return self
end

---@return Bullet
function Bullet:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    return self
end

---@param dt number # Time elapsed since last frame (seconds)
---@return Bullet
function Bullet:update(dt)
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
