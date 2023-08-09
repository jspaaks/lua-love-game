local Arrow = require "screens.playing.arrow"
local check = require "check-self"

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
    check(self, Arrows.__name__)
    local mt = { __index = Arrows }
    local members = {
        arrows = {},
        bow = bow
    }
    return setmetatable(members, mt)
end

---@return Arrows
function Arrows:draw()
    check(self, Arrows.__name__)
    for _, arrow in ipairs(self.arrows) do
        arrow:draw()
    end
    return self
end

---@return Arrows
function Arrows:mark_all_as_dead()
    check(self, Arrows.__name__)
    for _, arrow in ipairs(self.arrows) do
        arrow.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Arrows
function Arrows:update(dt)
    check(self, Arrows.__name__)

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
