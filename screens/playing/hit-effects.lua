local check = require "check-self"

---@class HitEffects # The collection of hit effects.
local HitEffects = {
    ---@type string # class name
    __name__ = "HitEffects",
    ---@type HitEffect[] | {} # array that holds the hit effects
    hit_effects = {}
}

---@return HitEffects
function HitEffects:new()
    check(self, HitEffects.__name__)
    local mt = { __index = HitEffects }
    local members = {}
    return setmetatable(members, mt)
end

---@return HitEffects
function HitEffects:draw()
    check(self, HitEffects.__name__)
    for _, hit in ipairs(self.hit_effects) do
        hit:draw()
    end
    return self
end

---@return HitEffects
function HitEffects:mark_all_as_dead()
    check(self, HitEffects.__name__)
    for _, hit in ipairs(self.hit_effects) do
        hit.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return HitEffects
function HitEffects:update(dt)
    check(self, HitEffects.__name__)

    -- delegate update to individual instances
    for _, hit_effect in ipairs(self.hit_effects) do
        hit_effect:update(dt)
    end

    -- remove dead
    for i, hit_effect in ipairs(self.hit_effects) do
        if not hit_effect.alive then
            table.remove(self.hit_effects, i)
        end
    end

    return self
end

return HitEffects
