local Base = require "knife.base"
local HitEffect = require "mbm.screens.playing.hit-effect"
local HitScore = require "mbm.screens.playing.hit-score"
local HitEffects = require "mbm.screens.playing.hit-effects"
local HitScores = require "mbm.screens.playing.hit-scores"

---@class Collisions                    # The collection of hit effects.
local Collisions = Base:extend()

---@param bullets Bullets               # Reference to the Bullets collection object
---@param balloons Balloons             # Reference to the Balloons collection object
---@return Collisions
function Collisions:constructor(bullets, balloons)
    ---@type Bullets                    # Reference to the Bullets collection object
    self.bullets = bullets
    ---@type Balloons                   # Reference to the Balloons collection object
    self.balloons = balloons
---@type HitEffects                     # Reference to the HitEffects collection
    self.hit_effects = HitEffects:new()
    ---@type HitScores                  # Reference to the HitScores collection
    self.hit_scores = HitScores:new()
    ---@type number                     # Number of Balloon instances that were hit
    self.nhit = 0
    return self
end

---@return Collisions
function Collisions:update(dt)

    self.hit_effects:update(dt)
    self.hit_scores:update(dt)

    -- calculate collisions, spawn hit effects and hit scores
    for _, bullet in ipairs(self.bullets.elements) do
        for _, balloon in ipairs(self.balloons.elements) do
            local dx = balloon.x - bullet.x
            local dy = balloon.y - bullet.y
            local d1 = math.sqrt(dx * dx + dy * dy)
            local d2 = bullet.radius + balloon.radius
            if d1 < d2 then
                local ratio = bullet.radius / (bullet.radius + balloon.radius)
                for _ = 0, math.random(3, 7), 1 do
                    local hit_effect = HitEffect:new(bullet.x + dx * ratio, bullet.y + dy * ratio)
                    table.insert(self.hit_effects.elements, hit_effect)
                    local hit_score = HitScore:new(balloon.x, balloon.y - balloon.radius - 15, balloon.u + 5, balloon.v - 10, balloon.value)
                    table.insert(self.hit_scores.elements, hit_score)
                end
                self.nhit = self.nhit + 1
                self.bullets.nremaining = self.bullets.nremaining + balloon.value
                bullet.alive = false
                balloon.alive = false
                balloon.sounds.pop:clone():play()
                balloon.sounds.score:clone():play()
            end
        end
    end
    return self
end


---@return Collisions
function Collisions:draw()
    self.hit_effects:draw()
    self.hit_scores:draw()
    return self
end


---@return Collisions
function Collisions:reset()
    self.hit_effects:reset()
    self.hit_scores:reset()
    self.nhit = 0
    return self
end


return Collisions
