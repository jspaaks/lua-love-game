---@class Bow # The Bow.
local Bow = {
    ---@type string # class name
    __name__ = "Bow",
    ---@type number | nil # horizontal position
    x = nil,
    ---@type number | nil # vertical position
    y = nil,
    ---@type number | nil # horizontal distance from the reference
    dx = nil,
    ---@type number | nil # vertical distance from the reference
    dy = nil,
    ---@type Ground | nil # reference to Ground object
    ground = nil,
    ---@type table<"shot", love.Source> # Arrow sounds
    sounds = {
        shot = love.audio.newSource("sounds/shot.wav", "static"),
    }
}

---@param dx number # bow's horizontal distance from the reference
---@param dy number # bow's vertical distance from the reference
---@param ground Ground # reference to ground object
---@return Bow
function Bow:new(dx, dy, ground)
    assert(self ~= nil, "Wrong signature for call to Bow:new")
    local mt = { __index = Bow }
    local members = {
        dx = dx,
        dy = dy,
        ground = ground
    }
    return setmetatable(members, mt)
end

---@return Bow
function Bow:draw()
    assert(self ~= nil, "Wrong signature for call to Bow:draw")
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.circle("fill", self.x, self.y, 4)
    return self
end

---@return Bow
function Bow:update()
    assert(self ~= nil, "Wrong signature for call to Bow:update")
    self.x = 0 + self.dx
    self.y = self.ground.y + self.dy
    return self
end

return Bow
