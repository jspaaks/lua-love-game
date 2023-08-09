local check = require "check-self"

---@class HitScores # The collection of hit scores.
local HitScores = {
    ---@type string # class name
    __name__ = "HitScores",
    ---@type HitScore[] | {} # array that holds the hit scores
    hit_scores = {}
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
    for _, hit_score in ipairs(self.hit_scores) do
        hit_score:draw()
    end
    return self
end

---@return HitScores
function HitScores:mark_all_as_dead()
    check(self, HitScores.__name__)
    for _, hit_score in ipairs(self.hit_scores) do
        hit_score.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return HitScores
function HitScores:update(dt)
    check(self, HitScores.__name__)

    -- delegate update to individual instances
    for _, hit_score in ipairs(self.hit_scores) do
        hit_score:update(dt)
    end

    -- remove dead
    for i, hit_score in ipairs(self.hit_scores) do
        if not hit_score.alive then
            table.remove(self.hit_scores, i)
        end
    end

    return self
end

return HitScores
