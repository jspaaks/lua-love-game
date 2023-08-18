local Base = require "knife.base"


---@class LevelFinishedScreen # The LevelFinishedScreen
local LevelFinishedScreen = Base:extend()


---@return LevelFinishedScreen
function LevelFinishedScreen:constructor()
    self.exit_reason = nil
    self.next_level = nil
    self.title = nil
    return self
end


---@return LevelFinishedScreen
function LevelFinishedScreen:update()
    if State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["return"] then
        State.screen:enter("playing"):reset({
            level = self.next_level
        })
        State.screen:change_to("playing")
    end
    State.fps:update()
    return self
end


---@return LevelFinishedScreen
function LevelFinishedScreen:draw()

    --screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf(self.title, 0, 275, 1280, "center")
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(self.exit_reason, 0, 350, 1280, "center")

    -- legend
    -- State.screen:enter("playing").balloons.elements = {}
    State.legend:draw()

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO CONTINUE", 0, y, 1280, "center")

    -- draw fps over everything else if need be
    State.fps:draw()

    return self
end


---@return LevelFinishedScreen
function LevelFinishedScreen:reset(params)
    if params ~= nil then
        self.exit_reason = params.exit_reason or self.exit_reason
        self.next_level = params.next_level or self.next_level
        self.title = params.title or self.title
    end
    return self
end

return LevelFinishedScreen
