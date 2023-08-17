local check = require "mbm.shared.check-self"

---@class Ground # The ground.
local Ground = {
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
    check(self, Ground.__name__)
    local mt = { __index = Ground }
    local _, height = love.graphics.getDimensions()
    local members = {
        thickness = thickness,
        y = height - thickness
    }
    return setmetatable(members, mt)
end

---@return Ground
function Ground:draw()
    check(self, Ground.__name__)
    local width, height = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", 0, self.y, width, height)
    return self
end

---@return Ground
function Ground:update()
    check(self, Ground.__name__)
    local _, height = love.graphics.getDimensions()
    self.y = height - self.thickness
    return self
end

return Ground
