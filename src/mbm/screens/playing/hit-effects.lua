local Base = require "knife.base"


---@class HitEffects # The collection of hit effects.
local HitEffects = Base:extend()


---@return HitEffects
function HitEffects:constructor()
    self.elements = {}
    return self
end


---@return HitEffects
function HitEffects:draw()
    for _, hit in ipairs(self.elements) do
        hit:draw()
    end
    return self
end


---@return HitEffects
function HitEffects:mark_all_as_dead()
    for _, hit in ipairs(self.elements) do
        hit.alive = false
    end
    return self
end


---@param dt number # time elapsed since last frame (seconds)
---@return HitEffects
function HitEffects:update(dt)

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


---@return HitEffects
function HitEffects:reset()
    self.elements = {}
    return self
end


return HitEffects
