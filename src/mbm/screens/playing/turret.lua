local Base = require "knife.base"
local clip = require "mbm.shared.clip"


---@class Turret # The Turret.
local Turret = Base:extend()

---@param ground Ground # reference to ground object
---@return Turret
function Turret:constructor(ground)
    ---@type number # Turret cannon angle that's most down
    self.angle_max = 1.95 * math.pi
    ---@type number # Turret cannon angle
    self.angle = self.angle_max
    ---@type number # Turret cannon angle that's most up
    self.angle_min = 1.6 * math.pi
    ---@type number # Turret cannon angle rate of change radians per second
    self.angle_rate = 0.3
    ---@type number # Turret cannon angle change direction
    self.angle_direction = -1
    ---@type table # properties of the base
    self.base = {
        ---@type number # width
        w = 70,
        ---@type number # height
        h = 25,
    }
    ---@type table # properties of the barrel
    self.barrel = {
        ---@type number # width
        w = 70,
        ---@type number # height
        h = 14
    }
    ---@type number[] # Turret color
    self.color = {50 / 255, 64 / 255, 46 / 255, 255 / 255}
    ---@type Ground # Reference to the Ground object
    self.ground = ground
    ---@type number # horizontal position
    self.x = 180
    ---@type number # vertical position
    self.y = ground.y - self.base.h
    ---@type table<"shot"|"empty", love.Source> # Turret sounds
    self.sounds = {
        empty = love.audio.newSource("sounds/empty.wav", "static"),
        shot = love.audio.newSource("sounds/shot.wav", "static"),
    }
    return self
end

---@return Turret
function Turret:draw()
    love.graphics.setColor(self.color)
    local x = self.x - self.base.w / 2

    -- base
    love.graphics.rectangle("fill", x, self.y, self.base.w, self.base.h)

    -- turret
    love.graphics.arc("fill", x + self.base.w / 2, self.y, self.base.w / 2, math.pi, 2 * math.pi, 20)

    -- cannon
    love.graphics.setColor(self.color)
    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.angle)
    love.graphics.rectangle("fill", 0, self.barrel.h / -2, self.barrel.w, self.barrel.h)
	love.graphics.pop()
    return self
end


---@return Turret
function Turret:reset()
    self.angle = self.angle_max
    return self
end


---@return Turret
function Turret:update(dt)
    self.y = self.ground.y - self.base.h
    if love.keyboard.isDown("w") then
        local new_angle = self.angle - self.angle_rate * dt
        self.angle = clip(new_angle, {self.angle_min, self.angle_max})
    elseif love.keyboard.isDown("s") then
        local new_angle = self.angle + self.angle_rate * dt
        self.angle = clip(new_angle, {self.angle_min, self.angle_max})
    end
    return self
end

return Turret
