local check = require "check-self"

---@class HitScore
local HitScore = {
    ---@type string # class name
    __name__ = "HitScore",
    ---@type number # How old the instance is
    age = 0,
    ---@type number # How old the instance can maximally be
    age_max = 1.8,
    ---@type boolean # Whether the instance is still alive
    alive = true,
    ---@type number[] # RGBA brightness
    color = {245 / 255, 255 / 255, 181 / 255, 255 / 255},
    ---@type love.Font # score font
    font = love.graphics.newFont("fonts/Bayon-Regular.ttf", 25),
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

---@return HitScore
function HitScore:new(x, y, u, v, value)
    check(self, HitScore.__name__)
    local mt = { __index = HitScore }
    local members = {
        u = u,
        v = v,
        value = value,
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

---@return HitScore
function HitScore:draw()
    check(self, HitScore.__name__)
    love.graphics.setColor(self.color)
    love.graphics.setFont(self.font)
    local s = string.format("+%d", self.value)
    love.graphics.printf(s, self.x - 50, self.y - 0.5 * self.font:getHeight(), 100, "center")
    return self
end

---@return HitScore
function HitScore:update(dt)
    check(self, HitScore.__name__)
    self.age = self.age + dt
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
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

return HitScore
