---@class Arrow # The arrow.
Arrow = {
    ---@type number # How old the arrow is
    age = nil,
    ---@type boolean # Whether the arrow is still alive
    alive = true,
    ---@type number[] # RGBA brightness
    color = {0, 128, 128, 255},
    ---@type number | nil # horizontal speed
    u = nil,
    ---@type number | nil # vertical speed
    v = nil,
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil
}

---@param u number # horizontal speed of the arrow
---@param v number # vertical speed of the arrow
---@param x number # horizontal position of the arrow
---@param y number # vertical position of the arrow
---@return Arrow
function Arrow:new(u, v, x, y)
    assert(self ~= nil, "Wrong signature for call to Arrow:new")
    local mt = { __index = Arrow }
    local members = {
        age = 0,
        u = u,
        v = v,
        x = x,
        y = y
    }
    return setmetatable(members, mt)
end

---@return Arrow
function Arrow:draw()
    assert(self ~= nil, "Wrong signature for call to Arrow:draw")
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, 4)
    return self
end

---@param dt number # Time elapsed since last frame (seconds)
---@return Arrow
function Arrow:update(dt)
    self.age = self.age + dt
    self.v = self.v + 0.5 * GRAVITY_ACCELERATION * dt * dt
    self.u = self.u
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
    -- check bounds
    local width, height = love.graphics.getDimensions()
    self.alive = self.alive and
                 self.age < 15 and
                 self.x > 0 and
                 self.x < width and
                 self.y > 0 and
                 self.y < height
    return self
end
