---@class Arrows # The collection of arrows.
Arrows = {
    ---@type number | nil # how fast arrows are spawning
    spawn_rate = nil,
    ---@type number | nil # where arrows are spawning (x)
    spawn_x = nil,
    ---@type number | nil # where arrows are spawning (y)
    spawn_y = nil
}


---@param spawn_x number # where arrows are spawning (x)
---@param spawn_y number # where arrows are spawning (y)
---@param spawn_rate number # how fast arrows are spawning
---@return Arrows
function Arrows:new(spawn_x, spawn_y, spawn_rate)
    local cond = self ~= nil and
                 type(spawn_rate) == "number" and
                 type(spawn_x) == "number" and
                 type(spawn_y) == "number"
    assert(cond, "Wrong signature for call to Arrows:new")
    local mt = { __index = Arrows }
    local members = {
        spawn_rate = spawn_rate,
        spawn_x = spawn_x,
        spawn_y = spawn_y
    }
    return setmetatable(members, mt)
end

---@return Arrows
function Arrows:draw()
    assert(self ~= nil, "Wrong signature for call to Arrows:draw")
    for _, arrow in ipairs(self) do
        arrow:draw()
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Arrows
function Arrows:update(dt)
    local cond = self ~= nil and type(dt) == "number"
    assert(cond, "Wrong signature for call to Arrows:update")
    if math.random() < self.spawn_rate * dt then
        local arrow = Arrow:new(70, -50, self.spawn_x, self.spawn_y)
        table.insert(self, arrow)
    end
    for _, arrow in ipairs(self) do
        arrow:update(dt)
    end
    for i, arrow in ipairs(self) do
        if not arrow.alive then
            table.remove(self, i)
        end
    end
    return self
end
