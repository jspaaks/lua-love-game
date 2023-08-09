local Arrow = require "screens.playing.arrow"

---@class Arrows # The collection of arrows.
local Arrows = {
    ---@type string # class name
    __name__ = "Arrows",
    ---@type Arrow[] | {} # array that holds the arrows
    arrows = {},
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
        arrows = {},
        bow = bow
    }
    return setmetatable(members, mt)
end

---@return Arrows
function Arrows:draw()
    assert(self ~= nil, "Wrong signature for call to Arrows:draw")
    for _, arrow in ipairs(self.arrows) do
        arrow:draw()
    end
    return self
end

---@return Arrows
function Arrows:mark_all_as_dead()
    assert(self ~= nil, "Wrong signature for call to Arrows:mark_all_as_dead")
    for _, arrow in ipairs(self.arrows) do
        arrow.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Arrows
function Arrows:update(dt)
    local cond = self ~= nil and type(dt) == "number"
    assert(cond, "Wrong signature for call to Arrows:update")

    -- spawn new arrow based on global keypressed state
    if State.keypressed["space"] then
        local arrow = Arrow:new(State.bow.x, State.bow.y, 280, -50)
        table.insert(self.arrows, arrow)
        State.bow.sounds.shot:clone():play()
    end

    -- delegate update to individual arrow instances
    for _, arrow in ipairs(self.arrows) do
        arrow:update(dt)
    end

    -- remove dead
    for i, arrow in ipairs(self.arrows) do
        if not arrow.alive then
            table.remove(self.arrows, i)
        end
    end

    return self
end

return Arrows
