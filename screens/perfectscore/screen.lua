---@class PerfectScoreScreen # The PerfectScoreScreen
local PerfectScoreScreen = {
    ---@type string # class name
    __name__ = "PerfectScoreScreen",
}


---@return PerfectScoreScreen
function PerfectScoreScreen:new()
    local mt = { __index = PerfectScoreScreen }
    local members = {}
    return setmetatable(members, mt)
end


---@return PerfectScoreScreen
function PerfectScoreScreen:update()
    if State.keypressed["q"] then
        love.event.quit(0)
    elseif State.keypressed["return"] then
        State.screen:enter("playing"):reset()
        State.screen:change_to("playing")
    end
    return self
end


---@return PerfectScoreScreen
function PerfectScoreScreen:draw()

    --screen background elements
    State.ground:draw()
    State.moon:draw()

    -- screen title
    love.graphics.setColor(State.colors.white)
    love.graphics.setFont(State.fonts["title"])
    love.graphics.printf("PERFECT SCORE", 0, 275, 1280, "center")
    love.graphics.setFont(State.fonts["small"])
    love.graphics.printf(State.screen:enter("playing").exit_reason, 0, 350, 1280, "center")

    -- scores
    State.screen:enter("playing").balloons.elements = {}
    State.score:draw()

    -- options to continue
    love.graphics.setColor(State.colors.lightgray)
    love.graphics.setFont(State.fonts["small"])
    local y = State.ground.y + State.ground.thickness * (1 / 2) - State.fonts.small:getHeight() / 2
    love.graphics.printf("Q TO QUIT  /  ENTER TO PLAY AGAIN", 0, y, 1280, "center")

    return self
end

return PerfectScoreScreen
