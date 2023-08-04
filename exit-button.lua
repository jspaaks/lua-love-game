ExitButton = {
    color = {255, 0, 128, 255},
    radius = 50,
    x = 20,
    y = 45,
}

function ExitButton:new()
    assert(self ~= nil, "Wrong signature for call to ExitButton:new")
    local mt = { __index = ExitButton }
    return setmetatable({}, mt)
end

function ExitButton:draw()
    assert(self ~= nil, "Wrong signature for call to ExitButton:draw")
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
