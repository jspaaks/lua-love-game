local Base = require "knife.base"


---@class Moon
local Moon = Base:extend()

---@return Moon
function Moon:constructor()
    self.color = {224 / 255,  220 / 255, 191 / 255, 255 / 255}
    self.radius = 45
    self.from_right = 100
    self.from_top = 70
    return self
end


function Moon:update()
    return self
end


function Moon:draw()
    local width, _ = love.graphics.getDimensions()
    love.graphics.setColor(self.color)
    local x1 = width - self.from_right
    local y1 = self.from_top
    love.graphics.circle("fill", x1, y1, self.radius)
    local bgcolor = { 0 / 255, 22 / 255, 43 / 255, 255 / 255 }
    love.graphics.setColor(bgcolor)
    local x2 = width - self.from_right - self.radius * 0.25
    local y2 = self.from_top - self.radius * 0.15
    love.graphics.circle("fill", x2, y2, self.radius * 0.95 )
end

return Moon
