---@class Arrows # The collection of arrows.
Arrows = {
    ---@type string # class name
    __name__ = "Arrows",
    ---@type Bow | nil # where arrows are spawning
    bow = nil
}


---@param bow Bow # reference to Bow object
---@return Arrows
function Arrows:new(bow)
    local cond = self ~= nil and
                 bow.__name__ == "Bow"
    assert(cond, "Wrong signature for call to Arrows:new")
    local mt = { __index = Arrows }
    local members = {
        bow = bow
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

---@return Arrows
function Arrows:remove_all()
    assert(self ~= nil, "Wrong signature for call to Arrows:remove_all")
    for _, arrow in ipairs(self) do
        arrow.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Arrows
function Arrows:update(dt)
    local cond = self ~= nil and type(dt) == "number"
    assert(cond, "Wrong signature for call to Arrows:update")
    if State.keypressed["space"] then
        local arrow = Arrow:new(State.bow.x, State.bow.y, 280, -50)
        table.insert(self, arrow)
        State.sounds["shot"]:clone():play()
    end
    for i, arrow in ipairs(self) do
        arrow:update(dt)
        if not arrow.alive then
            table.remove(self, i)
        end
    end
    return self
end

