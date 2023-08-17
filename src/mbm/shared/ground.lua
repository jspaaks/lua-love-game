local Base = require "knife.base"

---@class Ground
local Ground = Base:extend()


---@return Ground
function Ground:constructor(thickness)
    local _, height = love.graphics.getDimensions()
    self.color = {11 / 255, 1 / 255, 26/ 255, 255 / 255}
    self.thickness = thickness
    self.y = height - thickness
    return self
end

---@return Ground
function Ground:draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", 0, self.y, width, height)
    return self
end

---@return Ground
function Ground:update()
    local _, height = love.graphics.getDimensions()
    self.y = height - self.thickness
    return self
end

return Ground
