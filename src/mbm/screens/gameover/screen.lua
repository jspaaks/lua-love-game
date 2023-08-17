local Base = require "knife.base"

---@class GameoverScreen
local GameoverScreen = Base:extend()


---@return GameoverScreen
function GameoverScreen:constructor()
    return self
end


---@return GameoverScreen
function GameoverScreen:update()
    if State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["return"] then
        State.screen:enter("playing"):reset()
        State.screen:change_to("playing")
    end
    return self
end


---@return GameoverScreen
function GameoverScreen:draw()

    --screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("GAME OVER", 0, 275, 1280, "center")
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(State.screen:enter("playing").exit_reason, 0, 350, 1280, "center")

    -- legend
    State.screen:enter("playing").balloons.elements = {}
    State.legend:draw()

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY AGAIN", 0, y, 1280, "center")

    return self
end

return GameoverScreen
