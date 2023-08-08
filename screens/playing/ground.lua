---@class Ground # The ground.
Ground = {
    ---@type string # class name
    __name__ = "Ground",
    ---@type number[] # RGBA brightness
    color = {11 / 255, 1 / 255, 26/ 255, 255 / 255},
    ---@type number | nil # vertical length of the ground
    thickness = nil,
    ---@type number | nil # vertical position of the ground surface
    y = nil
}

---@return Ground
function Ground:new(thickness)
    assert(self ~= nil, "Wrong signature for call to Ground:new")
    local mt = { __index = Ground }
    local members = {
        thickness = thickness
    }
    return setmetatable(members, mt)
end

---@return Ground
function Ground:draw()
    assert(self ~= nil, "Wrong signature for call to Ground:draw")
    local width, height = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", 0, self.y, width, height)
    return self
end

---@return Ground
function Ground:update()
    assert(self ~= nil, "Wrong signature for call to Ground:update")
    local _, height = love.graphics.getDimensions()
    self.y = height - self.thickness
    return self
end
