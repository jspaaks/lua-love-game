local check = require "check-self"
local HitEffect = require "screens.playing.hit-effect"
local HitScore = require "screens.playing.hit-score"

---@class Collisions # The collection of hit effects.
local Collisions = {
    ---@type string # class name
    __name__ = "Collisions",
    ---@type Arrows | nil # Reference to the Arrows collection object
    arrows = nil,
    ---@type Balloons | nil # Reference to the Balloons collection object
    balloons = nil,
    ---@type number | nil # Cumulative value of Balloon instances that were hit
    cvalue = nil
}

---@param arrows Arrows # Reference to the Arrows collection object
---@param balloons Balloons # Reference to the Balloons collection object
---@return Collisions
function Collisions:new(arrows, balloons)
    check(self, Collisions.__name__)
    local mt = { __index = Collisions }
    local members = {
        arrows = arrows,
        balloons = balloons,
        cvalue = 0
    }
    return setmetatable(members, mt)
end

---@return Collisions
function Collisions:update()
    check(self, Collisions.__name__)

    -- calculate collisions, spawn hit effects and hit scores
    for _, arrow in ipairs(self.arrows.arrows) do
        for _, balloon in ipairs(self.balloons.balloons) do
            local dx = balloon.x - arrow.x
            local dy = balloon.y - arrow.y
            local d1 = math.sqrt(dx * dx + dy * dy)
            local d2 = arrow.radius + balloon.radius
            if d1 < d2 then
                local ratio = arrow.radius / (arrow.radius + balloon.radius)
                for _ = 0, math.random(3, 7), 1 do
                    local hit_effect = HitEffect:new(arrow.x + dx * ratio, arrow.y + dy * ratio)
                    table.insert(State.hit_effects.hit_effects, hit_effect)
                    local hit_score = HitScore:new(balloon.x, balloon.y - balloon.radius - 15, balloon.u + 5, balloon.v - 10, balloon.value)
                    table.insert(State.hit_scores.hit_scores, hit_score)
                end
                self.cvalue = self.cvalue + balloon.value
                State.arrows.remaining = State.arrows.remaining + balloon.value
                arrow.alive = false
                balloon.alive = false
                balloon.sounds.pop:clone():play()
                balloon.sounds.score:clone():play()
            end
        end
    end
    return self
end

return Collisions
