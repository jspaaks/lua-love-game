local Base = require "knife.base"

---@class HitScores # The collection of hit scores.
local HitScores = Base:extend()


---@return HitScores
function HitScores:constructor()
    self.elements = {}
    return self
end


---@return HitScores
function HitScores:draw()
    for _, element in ipairs(self.elements) do
        element:draw()
    end
    return self
end


---@return HitScores
function HitScores:mark_all_as_dead()
    for _, element in ipairs(self.elements) do
        element.alive = false
    end
    return self
end


---@return HitScores
function HitScores:reset(dt)
    self.elements = {}
    return self
end


---@param dt number # time elapsed since last frame (seconds)
---@return HitScores
function HitScores:update(dt)

    -- delegate update to individual instances
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


return HitScores
