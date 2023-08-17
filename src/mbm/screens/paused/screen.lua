local Base = require "knife.base"


---@class PausedScreen
local PausedScreen = Base:extend()


---@return PausedScreen
function PausedScreen:constructor()
    return self
end


---@return PausedScreen
function PausedScreen:update()
    State.ground:update()
    State.moon:update()
    State.legend:update()
    if State.keypressed["return"] then
        State.screen:change_to("playing")
    elseif State.keypressed["q"] then
        love.event.quit(0)
    end
    return self
end


---@return PausedScreen
function PausedScreen:draw()

    -- screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("PAUSED", 0, 275, 1280, "center")

    -- legend
    State.legend:draw()

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO RESUME", 0, y, 1280, "center")
    return self
end

return PausedScreen