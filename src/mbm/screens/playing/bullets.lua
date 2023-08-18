local Bullet = require "mbm.screens.playing.bullet"
local Base = require "knife.base"


---@class Bullets           # The collection of bullets.
local Bullets = Base:extend()


---@param turret Turret # reference to Turret object
---@return Bullets
function Bullets:constructor(turret, nalotted)
    ---@type Bullet[]       # array that holds the bullets
    self.elements = {}
    ---@type number         # how many bullets are remaining at the beginning of the run
    self.nalotted = nalotted or 100
    ---@type number         # how many bullets are remaining
    self.nremaining = self.nalotted
    ---@type number         # speed of the bullet
    self.speed = 220
    ---@type Turret         # where bullets are spawning
    self.turret = turret
    return self
end


---@return Bullets
function Bullets:draw()
    for _, element in ipairs(self.elements) do
        element:draw()
    end
    return self
end


---@return Bullets
function Bullets:mark_all_as_dead()
    for _, element in ipairs(self.elements) do
        element.alive = false
    end
    return self
end


---@return Bullets
function Bullets:reset(params)
    if params ~= nil then
        self.nalotted = params.nalotted or 103
    end
    self.elements = {}
    self.nremaining = self.nalotted
    return self
end


---@param dt number # time elapsed since last frame (seconds)
---@return Bullets
function Bullets:update(dt)
    -- spawn new bullet based on global keypressed state
    if State.keypressed["space"] then
        if self.nremaining > 0 then
            local u = math.cos(self.turret.angle) * self.speed
            local v = math.sin(self.turret.angle) * self.speed
            local x = self.turret.x + math.cos(self.turret.angle) * self.turret.barrel.w
            local y = self.turret.y + math.sin(self.turret.angle) * self.turret.barrel.w
            local element = Bullet(x, y, u, v)
            table.insert(self.elements, element)
            self.turret.sounds.shot:clone():play()
            self.nremaining = self.nremaining - 1
        else
            self.turret.sounds.empty:clone():play()
        end
    end

    -- delegate update to individual bullet instances
    for _, element in ipairs(self.elements) do
        element:update(dt)
    end

    -- remove dead
    for i, element in ipairs(self.elements) do
        if not element.alive then
            table.remove(self.elements, i)
        end
    end

    return self
end

return Bullets
