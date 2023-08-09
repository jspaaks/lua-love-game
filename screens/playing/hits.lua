local check = require "check-self"
local Hit = require "screens.playing.hit"

---@class Hits # The collection of hits.
local Hits = {
    ---@type string # class name
    __name__ = "Hits",
    ---@type Arrows | nil # Reference to the Arrows collection object
    arrows = nil,
    ---@type Balloons | nil # Reference to the Balloons collection object
    balloons = nil,
    ---@type Hit[] | {} # array that holds the hits
    hits = {}
}

---@param arrows Arrows # Reference to the Arrows collection object
---@param balloons Balloons # Reference to the Balloons collection object
---@return Hits
function Hits:new(arrows, balloons)
    check(self, Hits.__name__)
    local mt = { __index = Hits }
    local members = {
        arrows = arrows,
        balloons = balloons
    }
    return setmetatable(members, mt)
end

---@return Hits
function Hits:draw()
    check(self, Hits.__name__)
    for _, hit in ipairs(self.hits) do
        hit:draw()
    end
    return self
end

---@return Hits
function Hits:mark_all_as_dead()
    check(self, Hits.__name__)
    for _, hit in ipairs(self.hits) do
        hit.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Hits
function Hits:update(dt)
    check(self, Hits.__name__)

    -- calculate collisions, spawn hits
    for _, arrow in ipairs(self.arrows.arrows) do
        for _, balloon in ipairs(self.balloons.balloons) do
            local dx = balloon.x - arrow.x
            local dy = balloon.y - arrow.y
            local d1 = math.sqrt(dx * dx + dy * dy)
            local d2 = arrow.radius + balloon.radius
            if d1 < d2 then
                local ratio = arrow.radius / (arrow.radius + balloon.radius)
                for _ = 0, math.random(3, 7), 1 do
                    local u = math.random() * 2 - 1
                    local v = math.random() * 2 - 1
                    local hit = Hit:new(arrow.x + dx * ratio, arrow.y + dy * ratio, u * 20, v * 20)
                    table.insert(self.hits, hit)
                end
                arrow.alive = false
                balloon.alive = false
                balloon.sounds.pop:clone():play()
                balloon.sounds.score:clone():play()
            end
        end
    end

    -- delegate update to individual hit instances
    for _, hit in ipairs(self.hits) do
        hit:update(dt)
    end

    -- remove dead
    for i, hit in ipairs(self.hits) do
        if not hit.alive then
            table.remove(self.hits, i)
        end
    end

    return self
end

return Hits
