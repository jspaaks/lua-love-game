local Base = require "knife.base"


---@class LevelIndicator
local LevelIndicator = Base:extend()


---@return LevelIndicator
function LevelIndicator:constructor()
    self.fonts = {
        small = love.graphics.newFont("fonts/Bayon-Regular.ttf", 24),
        big = love.graphics.newFont("fonts/Bayon-Regular.ttf", 32)
    }
    self.level = ""
    self.nballoons = 0
    return self
end


---@return LevelIndicator
function LevelIndicator:draw()
    local y0 = 38       -- level
    local y1 = y0 + 41  -- balloons
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(self.fonts.small)
    love.graphics.printf(self.level .. " LEVEL", 0, y0, 1280, "center")
    love.graphics.printf(string.format("BALLOONS %d", self.nballoons), 0, y1, 1280, "center")
    return self
end


---@return LevelIndicator
function LevelIndicator:update(dt)
    self.nballoons = #State.screen:enter("playing").balloons.elements + #State.screen:enter("playing").balloons.remaining
    return self
end


---@return LevelIndicator
function LevelIndicator:reset(params)
    if params ~= nil then
        self.level = params.level or self.level
        self.nballoons = params.nballoons or self.nballoons
    end
    return self
end


return LevelIndicator
