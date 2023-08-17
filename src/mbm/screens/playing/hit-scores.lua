local check = require "mbm.shared.check-self"

---@class HitScores # The collection of hit scores.
local HitScores = {
    ---@type string # class name
    __name__ = "HitScores",
    ---@type HitScore[] | {} # array that holds the hit scores
    elements = {}
}


---@return HitScores
function HitScores:new()
    check(self, HitScores.__name__)
    local mt = { __index = HitScores }
    local members = {}
    return setmetatable(members, mt)
end


---@return HitScores
function HitScores:draw()
    check(self, HitScores.__name__)
    for _, element in ipairs(self.elements) do
        element:draw()
    end
    return self
end


---@return HitScores
function HitScores:mark_all_as_dead()
    check(self, HitScores.__name__)
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
    check(self, HitScores.__name__)

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
