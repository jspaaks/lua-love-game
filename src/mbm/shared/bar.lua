local Base = require "knife.base"

---@class Bar
local Bar = Base:extend()

---@param x number
---@param y number
---@param w number
---@param h number
function Bar:constructor(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
end


function Bar:update(dt)
end


function Bar:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Bar
