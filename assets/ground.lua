---@class Ground # The ground.
Ground = {
    ---@type number[] # RGBA brightness
    color = {34 / 255, 153 / 255, 84 / 255, 255 / 255},
    ---@type number | nil # vertical length of the ground
    thickness = nil,
    ---@type number | nil # vertical position of the ground surface
    y = nil
}

---@return Ground
function Ground:new(thickness)
    assert(self ~= nil, "Wrong signature for call to Ground:new")
    local _, height = love.graphics.getDimensions()
    local mt = { __index = Ground }
    local members = {
        thickness = thickness,
        y = height - thickness
    }
    return setmetatable(members, mt)
end

---@return Ground
function Ground:draw()
    assert(self ~= nil, "Wrong signature for call to Ground:draw")
    local width, height = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", 0, height - self.thickness, width, height)
    return self
end
