local Base = require "knife.base"


---@class SmallTitle
local SmallTitle = Base:extend()


---@return SmallTitle
function SmallTitle:constructor()
    self.fonts = {
        small = love.graphics.newFont("fonts/Bayon-Regular.ttf", 24),
        big = love.graphics.newFont("fonts/Bayon-Regular.ttf", 32)
    }
    self.y0 = 18            -- top line
    self.y1 = self.y0 - 13  -- big font
    self.y2 = self.y0 - 8   -- small font
    self.y3 = self.y0 + 26  -- bottom line
    return self
end


---@return SmallTitle
function SmallTitle:draw()
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setLineWidth(2)
    love.graphics.line(520, self.y0, 755, self.y0)
    love.graphics.line(538, self.y3, 741, self.y3)
    love.graphics.setFont(self.fonts.big)
    love.graphics.print("M", 519, self.y1)
    love.graphics.print("R", 743, self.y1)
    love.graphics.setFont(self.fonts.small)
    love.graphics.printf("IDNIGHT BALLOON MURDE", 0, self.y2, 1280, "center")
    return self
end


---@return SmallTitle
function SmallTitle:update(dt)
    return self
end


return SmallTitle
