local Balloon = require "screens.playing.balloon"
local BalloonTypes = require "screens.playing.balloon-types"
local check = require "check-self"


---@class Balloons           # The collection of balloons.
local Balloons = {
    ---@type string          # class name
    __name__ = "Balloons",
    ---@type Balloon[] | nil # array that holds the balloons
    balloons = nil,
    ---@type table           # classes of balloons and their properties
    classes = BalloonTypes,
    ---@type Ground | nil    # Reference to the Ground object
    ground = nil,
    ---@type Balloon[] | nil # array that holds the remaining balloons
    remaining = nil,
    ---@type number | nil    # how fast balloons are spawning
    spawn_rate = nil
}


---@param spawn_rate number  # how fast balloons are spawning
---@param ground Ground      # Reference to the Ground object
---@return Balloons
function Balloons:new(spawn_rate, ground)
    check(self, Balloons.__name__)
    local mt = { __index = Balloons }
    local members = {
        balloons = nil,
        ground = ground,
        spawn_rate = spawn_rate
    }
    self:reset()
    return setmetatable(members, mt)
end


---@return Balloons
function Balloons:draw()
    check(self, Balloons.__name__)
    for _, balloon in ipairs(self.balloons) do
        balloon:draw()
    end
    return self
end


---@return Balloons
function Balloons:mark_all_as_dead()
    check(self, Balloons.__name__)
    for _, balloon in ipairs(self.balloons) do
        balloon.alive = false
    end
    return self
end


---@return Balloons
function Balloons:reset()
    self.balloons = {}
    self.remaining = {}
    local width, _ = love.graphics.getDimensions()
    for _, bt in ipairs(BalloonTypes) do
        for _ = 1, bt.n, 1 do
            local x = width - 640 + math.random(0, 7) * 70
            local y = State.ground.y + bt.radius
            local u = 0
            local v = -20
            local balloon = Balloon:new(x, y, u, v, bt.color, bt.radius, bt.sounds, bt.value)
            table.insert(self.remaining, balloon)
        end
    end
    -- randomize the table
    for i = #self.remaining, 2, -1 do
        local j = math.random(i)
        self.remaining[i], self.remaining[j] = self.remaining[j], self.remaining[i]  -- shuffle i and j
    end
    return self
end


---@param dt number # time elapsed since last frame (seconds)
---@return Balloons
function Balloons:update(dt)
    check(self, Balloons.__name__)
    local width, _ = love.graphics.getDimensions()

    -- spawn balloons
    if #self.remaining >= 1 and #self.balloons == 0 or math.random() < self.spawn_rate * dt then
        local i = #self.remaining
        table.insert(self.balloons, self.remaining[i])
        table.remove(self.remaining, i)
    end

    -- delegate update to individual balloon instances
    for _, balloon in ipairs(self.balloons) do
        balloon:update(dt)
    end

    -- remove dead
    for i, balloon in ipairs(self.balloons) do
        if not balloon.alive then
            table.remove(self.balloons, i)
        end
    end

    return self
end

return Balloons
