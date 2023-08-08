---@class Hits # The collection of hits.
Hits = {
    ---@type string # class name
    __name__ = "Hits",
    ---@type Arrows | nil # Reference to the Arrows collection object
    arrows = nil,
    ---@type Balloons | nil # Reference to the Balloons collection object
    balloons = nil
}

---@param arrows Arrows # Reference to the Arrows collection object
---@param balloons Balloons # Reference to the Balloons collection object
---@return Hits
function Hits:new(arrows, balloons)
    local cond = self ~= nil and
                 arrows.__name__ == "Arrows" and
                 balloons.__name__ == "Balloons"
    assert(cond, "Wrong signature for call to Hits:new")
    local mt = { __index = Hits }
    local members = {
        arrows = arrows,
        balloons = balloons
    }
    return setmetatable(members, mt)
end

---@return Hits
function Hits:draw()
    assert(self ~= nil, "Wrong signature for call to Hits:draw")
    for _, hit in ipairs(self) do
        hit:draw()
    end
    return self
end

---@return Hits
function Hits:remove_all()
    assert(self ~= nil, "Wrong signature for call to Hits:remove_all")
    for _, hit in ipairs(self) do
        hit.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Hits
function Hits:update(dt)
    local cond = self ~= nil and type(dt) == "number"
    assert(cond, "Wrong signature for call to Hits:update")

    for _, arrow in ipairs(self.arrows) do
        for _, balloon in ipairs(self.balloons) do
            local dx = balloon.x - arrow.x
            local dy = balloon.y - arrow.y
            local d1 = math.sqrt(dx * dx + dy * dy)
            local d2 = arrow.radius + balloon.radius
            if d1 < d2 then
                local ratio = arrow.radius / (arrow.radius + balloon.radius)
                for i = 0, math.random(3, 7), 1 do
                    local u = math.random() * 2 - 1
                    local v = math.random() * 2 - 1
                    local hit = Hit:new(arrow.x + dx * ratio, arrow.y + dy * ratio, u * 20, v * 20)
                    table.insert(self, hit)
                end
                arrow.alive = false
                balloon.alive = false
                State.sounds["pop"]:clone():play()
                balloon["sound"]:clone():play()
            end
        end
    end

    for i, hit in ipairs(self) do
        hit:update(dt)
        if not hit.alive then
            table.remove(self, i)
        end
    end
    return self
end
