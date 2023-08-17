local Base = require "knife.base"

---@class HitEffect
local HitEffect = Base:extend()

---@return HitEffect
function HitEffect:constructor(x, y)
    ---@type number                         # How old the hit is
    self.age = 0
    ---@type number                         # How old the hit can maximally be
    self.age_max = 1.3
    ---@type boolean                        # Whether the hit is still alive
    self.alive = true
    ---@type number[]                       # RGBA brightness
    self.color = {245 / 255, 255 / 255, 181 / 255, 255 / 255}
    ---@type number                         # radius
    self.radius = 3
    ---@type number                         # radius at age 0
    self.radius_max = 3
    ---@type number                         # horizontal speed
    self.u = (math.random() * 2 - 1) * 30
    ---@type number                         # vertical speed
    self.v = (math.random() * 2 - 1) * 30
    ---@type number                         # horizontal position
    self.x = x
    ---@type number                         # vertical position
    self.y = y
    return self
end

---@return HitEffect
function HitEffect:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    return self
end

---@return HitEffect
function HitEffect:update(dt)
    self.age = self.age + dt
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
    self.radius = (1 - self.age / self.age_max) * self.radius_max
    -- check bounds
    local width, height = love.graphics.getDimensions()
    self.alive = self.alive and
                 self.age < self.age_max and
                 self.x > 0 and
                 self.x < width and
                 self.y > 0 and
                 self.y < height
    return self
end

return HitEffect
