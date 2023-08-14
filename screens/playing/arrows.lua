local Arrow = require "screens.playing.arrow"
local check = require "check-self"

---@class Arrows # The collection of arrows.
local Arrows = {
    ---@type string # class name
    __name__ = "Arrows",
    ---@type number  # how many arrows are remaining at the beginning of the run
    alotted = 10,
    ---@type Arrow[] | nil # array that holds the arrows
    arrows = nil,
    ---@type Bow | nil # where arrows are spawning
    bow = nil,
    ---@type number | nil  # how many arrows are remaining
    remaining = nil,
    ---@type number | nil  # horizontal position where arrows are spawning
    x = nil,
    ---@type number | nil  # vertical position where arrows are spawning
    y = nil
}


---@param bow Bow # reference to Bow object
---@return Arrows
function Arrows:new(bow)
    check(self, Arrows.__name__)
    local mt = { __index = Arrows }
    local members = {
        arrows = nil,
        bow = bow,
        remaining = nil,
        x = bow.x,
        y = bow.y
    }
    Arrows:reset()
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


---@return Arrows
function Arrows:reset()
    self.arrows = {}
    self.remaining = self.alotted
    return self
end


---@param dt number # time elapsed since last frame (seconds)
---@return Arrows
function Arrows:update(dt)
    check(self, Arrows.__name__)

    -- spawn new arrow based on global keypressed state
    if State.keypressed["space"] then
        if self.remaining > 0 then
            local arrow = Arrow:new(self.x, self.y, 280, -50)
            table.insert(self.arrows, arrow)
            self.bow.sounds.shot:clone():play()
            self.remaining = self.remaining - 1
        else
            self.bow.sounds.empty:clone():play()
        end
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
