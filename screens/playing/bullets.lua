local Bullet = require "screens.playing.bullet"
local check = require "check-self"

---@class Bullets # The collection of bullets.
local Bullets = {
    ---@type string # class name
    __name__ = "Bullets",
    ---@type Bullet[] | nil # array that holds the bullets
    elements = nil,
    ---@type number  # how many bullets are remaining at the beginning of the run
    nalotted = 10,
    ---@type number | nil  # how many bullets are remaining
    nremaining = nil,
    ---@type Turret | nil # where bullets are spawning
    turret = nil,
    ---@type number | nil  # horizontal position where bullets are spawning
    x = nil,
    ---@type number | nil  # vertical position where bullets are spawning
    y = nil
}


---@param turret Turret # reference to Turret object
---@return Bullets
function Bullets:new(turret)
    check(self, Bullets.__name__)
    local mt = { __index = Bullets }
    local members = {
        elements = nil,
        turret = turret,
        nremaining = nil,
        x = turret.x,
        y = turret.y
    }
    Bullets:reset()
    return setmetatable(members, mt)
end


---@return Bullets
function Bullets:draw()
    check(self, Bullets.__name__)
    for _, element in ipairs(self.elements) do
        element:draw()
    end
    return self
end


---@return Bullets
function Bullets:mark_all_as_dead()
    check(self, Bullets.__name__)
    for _, element in ipairs(self.elements) do
        element.alive = false
    end
    return self
end


---@return Bullets
function Bullets:reset()
    self.elements = {}
    self.nremaining = self.nalotted
    return self
end


---@param dt number # time elapsed since last frame (seconds)
---@return Bullets
function Bullets:update(dt)
    check(self, Bullets.__name__)

    -- spawn new bullet based on global keypressed state
    if State.keypressed["space"] then
        if self.nremaining > 0 then
            local element = Bullet:new(self.x, self.y, 280, -50)
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
