local Balloon = require "screens.playing.balloon"

---@class Balloons # The collection of balloons.
local Balloons = {
    ---@type string # class name
    __name__ = "Balloons",
    ---@type Balloon[] # array that holds the balloons
    balloons = {},
    ---@type table | nil # classes of balloons and their properties
    classes = {
        {
            color = {232 / 255, 86 / 255, 37 / 255, 255 / 255},   -- red
            cprob = 100,
            radius = 5,
            sounds = {
                pop = love.audio.newSource("sounds/pop.wav", "static"),
                score = love.audio.newSource("sounds/hit3.wav", "static")
            },
            value = 5
        },
        {
            color = {219 / 255, 149 / 255, 29 / 255, 255 / 255},  -- orange
            cprob = 75,
            radius = 10,
            sounds = {
                pop = love.audio.newSource("sounds/pop.wav", "static"),
                score = love.audio.newSource("sounds/hit2.wav", "static")
            },
            value = 3
        },
        {
            color = {219 / 255, 222 / 255, 80 / 255, 255 / 255},  -- yellow
            cprob = 40,
            radius = 14,
            sounds = {
                pop = love.audio.newSource("sounds/pop.wav", "static"),
                score = love.audio.newSource("sounds/hit1.wav", "static")
            },
            value = 1,
        },
    },
    ---@type Ground | nil # Reference to the Ground object
    ground = nil,
    ---@type number | nil # how fast balloons are spawning
    spawn_rate = nil
}


---@param spawn_rate number # how fast balloons are spawning
---@param ground Ground # Reference to the Ground object
---@return Balloons
function Balloons:new(spawn_rate, ground)
    local cond = self ~= nil and
                 type(spawn_rate) == "number"
    assert(cond, "Wrong signature for call to Balloons:new")
    local mt = { __index = Balloons }
    local members = {
        balloons = {},
        ground = ground,
        spawn_rate = spawn_rate
    }
    return setmetatable(members, mt)
end

---@return Balloons
function Balloons:draw()
    assert(self ~= nil, "Wrong signature for call to Balloons:draw")
    for _, balloon in ipairs(self.balloons) do
        balloon:draw()
    end
    return self
end

---@return Balloons
function Balloons:mark_all_as_dead()
    assert(self ~= nil, "Wrong signature for call to Balloons:mark_all_as_dead")
    for _, balloon in ipairs(self.balloons) do
        balloon.alive = false
    end
    return self
end

---@param dt number # time elapsed since last frame (seconds)
---@return Balloons
function Balloons:update(dt)
    local cond = self ~= nil and type(dt) == "number"
    assert(cond, "Wrong signature for call to Balloons:update")
    local width, _ = love.graphics.getDimensions()

    -- spawn balloons
    if math.random() < self.spawn_rate * dt then
        local color = nil
        local radius = nil
        local sounds = nil
        local rand = math.random() * 100
        for _, row in ipairs(self.classes) do
            if rand < row.cprob then
                color = row.color
                radius = row.radius
                sounds = row.sounds
            end
        end
        local x = width - 640 + math.random(0, 7) * 70
        local y = State.ground.y - radius
        local u = 0
        local v = -20
        local balloon = Balloon:new(x, y, u, v, color, radius, sounds)
        table.insert(self.balloons, balloon)
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
