local Base = require "knife.base"

---@class Balloon
local Balloon = Base:extend()


---@return Balloon
function Balloon:constructor(x, y, u, v, color, radius, sounds, value)
    self.alive = true
    self.age = 0
    self.color = color or {0, 128, 128, 255}
    self.radius = radius or 10
    self.sounds = sounds or {}
    self.u = u or 0
    self.v = v or 0
    self.value = value or 1
    self.x = x
    self.y = y
    return self
end

---@return Balloon
function Balloon:draw()
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
