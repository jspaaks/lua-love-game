local check = require "check-self"

---@class Hit
local Hit = {
    ---@type string # class name
    __name__ = "Hit",
    ---@type number # How old the hit is
    age = nil,
    ---@type number # How old the hit can maximally be
    age_max = 1.3,
    ---@type boolean # Whether the hit is still alive
    alive = true,
    ---@type number[] # RGBA brightness
    color = {245 / 255, 255 / 255, 181 / 255, 255 / 255},
    ---@type number # radius
    radius = 2,
    ---@type number # radius at age 0
    radius_max = 2,
    ---@type number | nil # horizontal speed
    u = nil,
    ---@type number | nil # vertical speed
    v = nil,
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil
}

---@return Hit
function Hit:new(x, y, u, v)
    check(self, Hit.__name__)
    local mt = { __index = Hit }
    local members = {
        age = 0,
        u = u,
        v = v,
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

---@return Hit
function Hit:draw()
    check(self, Hit.__name__)
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    return self
end

---@return Hit
function Hit:update(dt)
    check(self, Hit.__name__)
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

return Hit
