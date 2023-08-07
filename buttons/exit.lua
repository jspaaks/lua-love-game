---@class ExitButton # The exit button.
ExitButton = {
    ---@type number[] # RGBA brightness
    color = {23 / 255, 113 / 255, 179 / 255, 255 / 255},
    ---@type number # radius
    radius = 20,
    ---@type number # radius squared
    radius2 = 400,
    ---@type number # horizontal position
    from_right = 100,
    ---@type number # vertical position
    from_top = 70
}

---@return ExitButton
function ExitButton:new()
    assert(self ~= nil, "Wrong signature for call to ExitButton:new")
    local mt = { __index = ExitButton }
    return setmetatable({}, mt)
end

function ExitButton:draw()
    assert(self ~= nil, "Wrong signature for call to ExitButton:draw")
    local width, _ = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", width - self.from_right, self.from_top, self.radius)
end
