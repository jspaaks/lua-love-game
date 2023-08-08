---@class Balloon
Balloon = {
    ---@type string # class name
    __name__ = "Balloon",
    ---@type number # How old the balloon is
    age = nil,
    ---@type boolean # Whether the balloon is still alive
    alive = true,
    ---@type number[] # array of RGBA brightness
    color = {0, 128, 128, 255},
    ---@type number # balloon radius
    radius = 10,
    ---@type love.Source | nil # balloon sound
    sound = nil,
    ---@type number | nil # horizontal speed
    u = nil,
    ---@type number | nil # vertical speed
    v = nil,
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil
}

---@return Balloon
function Balloon:new(x, y, u, v, color, radius, sound)
    assert(self ~= nil, "Wrong signature for call to Balloon:new")
    local mt = { __index = Balloon }
    local members = {
        age = 0,
        color = color,
        radius = radius,
        sound = sound,
        u = u,
        v = v,
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

---@return Balloon
function Balloon:draw()
    assert(self ~= nil, "Wrong signature for call to Balloon:draw")
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    return self
end

---@return Balloon
function Balloon:update(dt)
    self.age = self.age + dt
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
    -- check bounds
    local width, height = love.graphics.getDimensions()
    self.alive = self.alive and
                 self.age < 35 and
                 self.x > 0 and
                 self.x < width and
                 self.y > 0 and
                 self.y < height
    return self
end
