local check = require "check-self"
local clip = require "clip"

---@class Turret # The Turret.
local Turret = {
    ---@type string # class name
    __name__ = "Turret",
    ---@type number | nil # Turret cannon angle
    angle = 1.95 * math.pi,
    ---@type number | nil # Turret cannon angle that's most up
    angle_min = 1.6 * math.pi,
    ---@type number | nil # Turret cannon angle that's most down
    angle_max = 1.95 * math.pi,
    ---@type number | nil # Turret cannon angle rate of change radians per second
    angle_rate = 0.3,
    ---@type number | nil # Turret cannon angle change direction
    angle_direction = -1,
    ---@type table # properties of the base
    base = {
        ---@type number | nil # width
        w = 70,
        ---@type number | nil # height
        h = 25,
    },
    ---@type table # properties of the barrel
    barrel = {
        ---@type number | nil # width
        w = 70,
        ---@type number | nil # height
        h = 10
    },
    ---@type number[] # Turret color
    color = {50 / 255, 64 / 255, 46 / 255, 255 / 255},
    ---@type Ground | nil # Reference to the Ground object
    ground = nil,
    ---@type number | nil # horizontal position
    x = 180,
    ---@type number | nil # vertical position
    y = nil,
    ---@type table<"shot"|"empty", love.Source> # Turret sounds
    sounds = {
        empty = love.audio.newSource("sounds/empty.wav", "static"),
        shot = love.audio.newSource("sounds/shot.wav", "static"),
    }
}

---@param ground Ground # reference to ground object
---@return Turret
function Turret:new(ground)
    check(self, Turret.__name__)
    local mt = { __index = Turret }
    local members = {
        angle = self.angle_max,
        ground = ground,
        y = ground.y - self.base.h
    }
    return setmetatable(members, mt)
end

---@return Turret
function Turret:draw()
    check(self, Turret.__name__)
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
    check(self, Turret.__name__)
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
