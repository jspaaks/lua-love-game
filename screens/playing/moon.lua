local check = require "check-self"

---@class Moon # The Moon.
local Moon = {
    ---@type string # class name
    __name__ = "Moon",
    ---@type number[] # RGBA brightness
    color = {224 / 255,  220 / 255, 191 / 255, 255 / 255},
    ---@type number # radius
    radius = 30,
    ---@type number # horizontal position
    from_right = 100,
    ---@type number # vertical position
    from_top = 70
}

---@return Moon
function Moon:new()
    check(self, Moon.__name__)
    local mt = { __index = Moon }
    local members = {
        __name__ = "Moon",
    }
    return setmetatable(members, mt)
end

function Moon:draw()
    check(self, Moon.__name__)
    local width, _ = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    local x1 = width - self.from_right
    local y1 = self.from_top
    love.graphics.circle("fill", x1, y1, self.radius)
    local bgcolor = { 0 / 255, 22 / 255, 43 / 255, 255 / 255 }
    love.graphics.setColor(bgcolor)
    local x2 = width - self.from_right - self.radius * 0.25
    local y2 = self.from_top - self.radius * 0.25
    love.graphics.circle("fill", x2, y2, self.radius)
end

return Moon
