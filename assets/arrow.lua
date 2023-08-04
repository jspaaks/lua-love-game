---@class Arrow # The arrow.
Arrow = {
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

---@return Arrow
function Arrow:new(u, v, x0, y0)
    assert(self ~= nil, "Wrong signature for call to Arrow:new")
    local mt = { __index = Arrow }
    local members = {
        u = u,
        v = v,
        x = x0,
        y = y0
    }
    return setmetatable(members, mt)
end

function Arrow:draw()
    assert(self ~= nil, "Wrong signature for call to Arrow:draw")
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, 4)

end

function Arrow:update(dt)
    self.x = self.x + self.u * dt
    self.y = self.y + self.v * dt
    if self.x > 400 then
        self.alive = false
    end
end
