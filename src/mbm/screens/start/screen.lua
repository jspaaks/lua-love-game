local Base = require "knife.base"
local Fps = require "mbm.shared.fps"


---@class StartScreen
local StartScreen = Base:extend()


---@return StartScreen
function StartScreen:constructor()
    self.fps = Fps()
    return self
end


---@return StartScreen
function StartScreen:update()
    State.ground:update()
    State.moon:update()
    self.fps:update()
    if State.keypressed["return"] then
        State.screen:change_to("playing")
    elseif State.keypressed["q"] then
        love.event.quit(0)
    end
    return self
end


---@return StartScreen
function StartScreen:draw()
    -- background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("MIDNIGHT BALLOON MURDER", 0, 275, 1280, "center")

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY", 0, y, 1280, "center")

    -- draw fps over everything else if need be
    self.fps:draw()

    return self
end

return StartScreen
