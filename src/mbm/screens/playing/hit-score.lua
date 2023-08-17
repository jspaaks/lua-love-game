local Base = require "knife.base"

---@class HitScore
local HitScore = Base:extend()


---@return HitScore
function HitScore:constructor(x, y, u, v, value)

    ---@type number          # How old the instance is
    self.age = 0

    ---@type number          # How old the instance can maximally be
    self.age_max = 1.8

    ---@type boolean         # Whether the instance is still alive
    self.alive = true

    ---@type number[]        # RGBA brightness
    self.color = {245 / 255, 255 / 255, 181 / 255, 255 / 255}

    ---@type love.Font       # score font
    self.font = love.graphics.newFont("fonts/Bayon-Regular.ttf", 25)

    ---@type number          # horizontal speed
    self.u = u

    ---@type number          # vertical speed
    self.v = v

    ---@type number          # value
    self.value = value

    ---@type number          # horizontal position
    self.x = x

    ---@type number          # vertical position
    self.y = y

    return self
end

---@return HitScore
function HitScore:draw()
    love.graphics.setColor(self.color)
    love.graphics.setFont(self.font)
    local s = string.format("+%d", self.value)
    love.graphics.printf(s, self.x - 50, self.y - 0.5 * self.font:getHeight(), 100, "center")
    return self
end

---@return HitScore
function HitScore:update(dt)
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
